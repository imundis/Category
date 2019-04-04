//
//  GSProxy.h
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GSProxy : NSProxy<NSObject>

+ (instancetype)createProxy;
- (void)addTargetWithClass:(Class)class;
- (id)performSelector:(SEL)aSelector withObjetcs:(NSArray * _Nullable)params;

@end

NS_ASSUME_NONNULL_END
