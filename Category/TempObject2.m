//
//  TempObject2.m
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import "TempObject2.h"

@implementation TempObject2

- (NSNumber *)temp2:(NSString *)str1 number:(NSNumber *)num {
    NSLog(@"temp2 %@ %@", str1, num);
    return [NSNumber numberWithInteger:10];
}

@end
