//
//  GCDTimerManager+Name.m
//  Category
//
//  Created by 郭帅 on 2018/12/12.
//  Copyright © 2018 Category. All rights reserved.
//

#import "GCDTimerManager+Name.h"
#import <objc/runtime.h>

static void *nameKey = &nameKey;

@implementation GCDTimerManager (Name)

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &nameKey);
}

@end
