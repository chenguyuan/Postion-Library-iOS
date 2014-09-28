//
//  YCLocationManager.h
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "YCLocationManagerDelegate.h"
#import "YCLocation.h"

@interface YCLocationManager : NSObject <CLLocationManagerDelegate>

@property (assign, nonatomic) id <YCLocationManagerDelegate> delegate;

-(instancetype)init;

-(UIImage *)currentMapImage;
-(void)requestAlwaysAuthorization;
-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;

@end
