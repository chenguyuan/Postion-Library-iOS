//
//  YCLocationManagerDelegate.h
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCLocation.h"

@protocol YCLocationManagerDelegate <NSObject>

@optional
-(void)YCGetLocation:(YCLocation *)location;

@end
