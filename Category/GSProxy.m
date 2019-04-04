//
//  GSProxy.m
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import "GSProxy.h"
#import <objc/runtime.h>

@interface GSProxy()

@property (strong, nonatomic) NSMutableArray *targetArr;
@property (strong, nonatomic) NSMutableDictionary *methodsMap;

@end

@implementation GSProxy

+ (instancetype)createProxy {
    return [[GSProxy alloc] init];
}

- (instancetype)init {
    self.targetArr = [[NSMutableArray alloc] init];
    self.methodsMap = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (void)addTargetWithClass:(Class)class {
    id newTarget = [[class alloc] init];
    [self.targetArr addObject:newTarget];
    [self registerMethodsWithTarget:newTarget];
}

- (void)registerMethodsWithTarget:(id)target {
    unsigned int numberOfMethods = 0;
    Method *method_list = class_copyMethodList([target class], &numberOfMethods);
    for (int i = 0; i < numberOfMethods; i++) {
        Method temp_method = method_list[i];
        SEL temp_sel = method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [self.methodsMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    
    free(method_list);
}

- (id)performSelector:(SEL)sel withObjetcs:(NSArray * _Nullable)params {
    NSMethodSignature *signature = [self methodSignatureForSelector:sel];
    if (!signature) {
        NSString *info = [NSString stringWithFormat:@"- [%@ %@]:", [self class], NSStringFromSelector(sel)];
        @throw [[NSException alloc] initWithName:@"方法不存在" reason:info userInfo:nil];
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:sel];
    
    NSInteger arguments = signature.numberOfArguments - 2;
    NSUInteger objCount = params.count;
    NSInteger count = MIN(arguments, objCount);
    for (int i = 0; i < count; i++) {
        NSObject *obj = params[i];
        if ([obj isKindOfClass:[NSNull class]]) {
            obj = nil;
        }
        [invocation setArgument:&obj atIndex:(i + 2)];
    }
    
    [invocation invoke];
    
    id res = nil;
    if (signature.methodReturnLength != 0) {
        [invocation getReturnValue:&res];
    }
    
    return res;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *methodName = NSStringFromSelector(sel);
    id target = self.methodsMap[methodName];
    
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = invocation.selector;
    NSString *methodName = NSStringFromSelector(sel);
    id target = self.methodsMap[methodName];
    
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
