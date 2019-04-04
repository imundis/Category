//
//  TempObject1.m
//  Category
//
//  Created by 郭帅 on 2018/10/16.
//  Copyright © 2018 Category. All rights reserved.
//

#import "TempObject1.h"

@interface TempObject1()

@property (nonatomic, copy, getter=getName) NSString *name;

@end

@implementation TempObject1

@synthesize name = theName;

- (void)temp1:(NSString *)str {
    NSLog(@"temp1 %@", str);
    theName = str;
}

- (void)setName:(NSString *)name {
    theName = name;
}

- (NSString *)getName {
    return theName;
}

@end
