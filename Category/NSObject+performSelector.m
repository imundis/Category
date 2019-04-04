//
//  NSObject+performSelector.m
//  Category
//
//  Created by 郭帅 on 2018/10/15.
//  Copyright © 2018 Category. All rights reserved.
//

#import "NSObject+performSelector.h"

@implementation NSObject (performSelector)

- (id)performSelector:(SEL)aSelector withObjetcs:(NSArray * _Nullable)params {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (!signature) {
        NSString *info = [NSString stringWithFormat:@"- [%@ %@]:", [self class], NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"方法不存在" reason:info userInfo:nil];
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
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
    
//    id res = nil;
//    if (signature.methodReturnLength != 0) {
////        NSLog(@"%s", signature.methodReturnType);
//        [invocation getReturnValue:&res];
//        if (strcmp(signature.methodReturnType, "i") == 0) {
//            int num = (int)res;
//            return @(num);
//        }
//    }
//
//    return res;
    if (signature.methodReturnLength != 0) {
        if (strcmp(signature.methodReturnType, "i") == 0) {
            int num;
            [invocation getReturnValue:&num];
            return @(num);
        } else {
            id res = nil;
            [invocation getReturnValue:&res];
            return res;
        }
    } else {
        return nil;
    }
}

@end
