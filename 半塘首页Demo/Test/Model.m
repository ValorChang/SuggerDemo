//
//  Model.m
//  CarouselDemo
//
//  Created by 常迪 on 15/11/9.
//  Copyright © 2015年 常迪. All rights reserved.
//

#import "Model.h"
#import "Header.h"

@implementation Model

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identify"];
    }
}

- (void)setNilValueForKey:(NSString *)key{
    
}

@end
