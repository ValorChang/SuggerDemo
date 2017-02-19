//
//  BanndrModel.m
//  Test
//
//  Created by 常迪 on 15/11/10.
//  Copyright (c) 2015年 常迪. All rights reserved.
//

#import "BanndrModel.h"

@implementation BanndrModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"title"]) {
        [self setValue:value forKey:@"title1"];
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}


@end
