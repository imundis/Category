//
//  GCDTimerManager.m
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import "GCDTimerManager.h"

@interface GCDTimerManager()

@property (strong, nonatomic) NSMutableDictionary *timerContainer;

@end

@implementation GCDTimerManager

static GCDTimerManager *_instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [GCDTimerManager sharedInstance];
}

- (void)scheduledDspatchTimerWithName:(NSString * _Nonnull)name
                         timeInterval:(NSTimeInterval)interval
                                queue:(dispatch_queue_t _Nullable)queue
                              repeats:(GCDTimerRepeatTimes)repeats
                               action:(dispatch_block_t)action {
    [self cancelTimerWithName:name];
    
    if (nil == queue)
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = [self.timerContainer objectForKey:name];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_resume(timer);
        [self.timerContainer setObject:timer forKey:name];
    }
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    
    __weak typeof(self) weakSelf = self;
    __block int repeatTimes = repeats;
    dispatch_source_set_event_handler(timer, ^{
        action();
        
        if (repeatTimes == GCDTimerRepeatNever) {
            [weakSelf cancelTimerWithName:name];
        } else {
            repeatTimes--;
        }
    });
}

- (void)cancelTimerWithName:(NSString *)name {
    dispatch_source_t timer = [self.timerContainer objectForKey:name];
    
    if (!timer)
        return ;
    
    dispatch_source_cancel(timer);
    [self.timerContainer removeObjectForKey:name];
}

- (NSMutableDictionary *)timerContainer {
    if (!_timerContainer) {
        _timerContainer = [[NSMutableDictionary alloc] init];
    }
    
    return _timerContainer;
}

@end
