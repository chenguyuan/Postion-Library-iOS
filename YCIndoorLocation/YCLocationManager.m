//
//  YCLocationManager.m
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import "YCLocationManager.h"
#import "YCMapData.h"

@interface YCLocationManager ()

@property (strong, nonatomic) CLBeaconRegion *region;
@property (strong, nonatomic) NSUUID *uuid;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) YCMapData *mapData;

//能否去掉？
@property int lastFPID;

@end

#define kUUID @"d26d197e-4a1c-44ae-b504-dd7768870564"
#define kIdentifier @"YCIndoorLocation"
#define kMapName @"Finland_AVP"

@implementation YCLocationManager

#pragma mark -------初始化-------
-(instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc]init];
        _uuid = [[NSUUID alloc]initWithUUIDString:kUUID];
        
        //初始化mapData
        _mapData = [[YCMapData alloc] initWithMapName:kMapName];
    }
    return self;
}

#pragma mark -------获取定位基本参数-------
-(UIImage *)currentMapImage
{
    return _mapData.mapImage;
}


#pragma mark -------定位开关-------
-(void)startUpdatingLocation
{
    if (_mapData == nil) {
        return;
    }
    
    _region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid major:_mapData.major identifier:kIdentifier];
    _locationManager.delegate = self;
    
    [_locationManager startRangingBeaconsInRegion:_region];
    
    _lastFPID = -1;
}

-(void)stopUpdatingLocation
{
    [_locationManager stopRangingBeaconsInRegion:_region];
    _region = nil;
}

//权限申请
-(void)requestAlwaysAuthorization
{
    [_locationManager requestAlwaysAuthorization];
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [_locationManager requestAlwaysAuthorization];
        NSLog(@"没有定位权限");
    }
}


#pragma mark -------扫描-------
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count == 0) {
        NSLog(@"附近没有蓝牙设备");
    } else {
        [self simpleAlgorithmUsingBeacons:beacons];
    }
}

#pragma mark -------算法部分-------

//点对点算法
-(void)simpleAlgorithmUsingBeacons:(NSArray *)beacons
{
    for (CLBeacon *beacon in beacons) {
        if (beacon.proximity != CLProximityUnknown ) {
            int FPID = [beacon.minor intValue];
            CGPoint currentCoordinate = [_mapData coordinateWithID:FPID];
            
            if (currentCoordinate.x <= 0) {
                continue;
            } else if (FPID != _lastFPID){
                YCLocation *location = [[YCLocation alloc]initWithCoordinate:currentCoordinate];
                [_delegate YCGetLocation:location];
                _lastFPID = FPID;
                NSLog(@"位置变化 目前位置为 : %d", FPID);
                break;
            } else {
                break;
            }
        }
    }
}



@end
