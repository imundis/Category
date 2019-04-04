//
//  ViewController.m
//  Category
//
//  Created by 郭帅 on 2018/10/15.
//  Copyright © 2018 Category. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+performSelector.h"
#import "GSProxy.h"
#import "TempObject1.h"
#import "TempObject2.h"
#import "GCDTimerManager.h"
#import "GCDTimerManager+Name.h"
#import "Category-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 2; ++i) {
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
            }
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 2; ++i) {
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
            }
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 2; ++i) {
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
            }
        });
    });
}

#pragma mark -- test
- (void)proxy {
    GSProxy *proxy = [GSProxy createProxy];
    [proxy addTargetWithClass:[TempObject1 class]];
    [proxy addTargetWithClass:[TempObject2 class]];
    [proxy performSelector:NSSelectorFromString(@"temp1:") withObjetcs:@[@"haha"]];
    [proxy performSelector:NSSelectorFromString(@"temp2:number:") withObjetcs:@[@"lolo", [NSNumber numberWithInteger:10]]];
}

- (void)performSelector {
    [self performSelector:@selector(test2) withObjetcs:nil];
}

- (NSNumber *)test {
    return [NSNumber numberWithInteger:10];
}

- (int)test2 {
    return 20;
}

- (void)timer {
    [[GCDTimerManager sharedInstance] scheduledDspatchTimerWithName:@"timer" timeInterval:1 queue:nil repeats:3 action:^{
        NSLog(@"timer");
    }];
}

@end
