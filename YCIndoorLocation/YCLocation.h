//
//  YCLocation.h
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface YCLocation : NSObject

-(instancetype)initWithCoordinate:(CGPoint)coordinate;
-(instancetype)initWithCoordinate:(CGPoint)coordinate accuracy:(double)accuracy;

@property (readonly, nonatomic) CGPoint coordinate;
@property (readonly, nonatomic) double accuracy;

@end
