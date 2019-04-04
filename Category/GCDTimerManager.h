//
//  GCDTimerManager.h
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GCDTimerRepeatTimes) {
    GCDTimerRepeatNever = 0,
    GCDTimerRepeatForever = INT_MAX
};

@interface GCDTimerManager : NSObject

+ (instancetype)sharedInstance;

- (void)scheduledDspatchTimerWithName:(NSString * _Nonnull)name
                         timeInterval:(NSTimeInterval)interval
                                queue:(dispatch_queue_t _Nullable)queue
                              repeats:(GCDTimerRepeatTimes)repeats
                               action:(dispatch_block_t)action;

- (void)cancelTimerWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
