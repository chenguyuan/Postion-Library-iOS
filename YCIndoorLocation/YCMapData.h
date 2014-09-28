//
//  YCMapData.h
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCMapData : NSObject

//地图相关参数
@property (readonly, nonatomic) NSString *mapName;
@property (readonly, nonatomic) int major;
@property (readonly, nonatomic) double mapScale;
@property (readonly, nonatomic) double mapOrientation;
@property (readonly, nonatomic) UIImage *mapImage;

//当前地图所有的指纹组
@property (readonly, nonatomic) NSArray *allFingerprints;

//根据地图名称初始化
-(instancetype)initWithMapName:(NSString *)mapName;

//根据FPID获取坐标
-(CGPoint)coordinateWithID:(int)FPID;

@end
