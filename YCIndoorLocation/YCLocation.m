//
//  YCLocation.m
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import "YCLocation.h"

@implementation YCLocation

-(instancetype)initWithCoordinate:(CGPoint)coordinate
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _accuracy = -1;
    }
    return self;
}

-(instancetype)initWithCoordinate:(CGPoint)coordinate accuracy:(double)accuracy
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _accuracy = accuracy;
    }
    return self;
}


@end
