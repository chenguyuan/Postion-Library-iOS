//
//  YCMapData.m
//  YCIndoorLocation
//
//  Created by yutian on 14-9-18.
//  Copyright (c) 2014年 YongChang. All rights reserved.
//

#import "YCMapData.h"
#import <FMDB.h>

@interface YCMapData ()

@property (strong, nonatomic) FMDatabase *database;
@property CGPoint errorCoordinate;

@end
#define kDatabaseName @"IndoorPosition.db"

@implementation YCMapData

#pragma mark -------初始化-------
-(instancetype)initWithMapName:(NSString *)mapName
{
    self = [super init];
    if (self) {
        NSString *databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];
        _database = [[FMDatabase alloc] initWithPath:databasePath];
        //设置错误坐标状态，用作之后判断并报错
        _errorCoordinate = CGPointMake(-1, -1);
        [_database open];
        
        //获取数据并初始化
        _mapName = mapName;
        if (![self setMapValue]) {
            return nil;
        }
    }
    return self;
}

-(BOOL)copyDatabase
{
    return false;
}

-(BOOL)setMapValue
{
    NSString *query = [NSString stringWithFormat:@"select * from MapToMajor where Map = '%@'", _mapName];
    FMResultSet *results = [_database executeQuery:query];
    
    //隐藏问题，如果有多个result，可能会造成错误。需要改进
    while ([results next]) {
        _mapScale = [results doubleForColumn:@"Scale"];
        _mapOrientation = [results doubleForColumn:@"Orientation"];
        _major = [results intForColumn:@"major"];
        
        NSData *imageData = [results dataForColumn:@"MapContent"];
        _mapImage = [UIImage imageWithData:imageData];
        if (_mapImage == nil) {
            NSLog(@"读取地图数据失败");
        }
        return true;
    }
    
    NSLog(@"读取数据库失败");
    return false;
}

-(void)setAllFingerPrints
{
    
}

#pragma mark -------查询-------
-(CGPoint)coordinateWithID:(int)FPID
{
    //TODO:  优化数据库结构，是否可以不必使用这样的方式查找特定的table？
    NSString *query = [NSString stringWithFormat:@"Select * from FPID_%@ where FPID = '%d' ", _mapName ,FPID];
    FMResultSet *results = [_database executeQuery:query];
    if ([results columnCount]==0) {
        return CGPointMake(-1,-1);
    }
    while ([results next]) {
        CGPoint currentCoordinate;
        currentCoordinate.x = [results intForColumn:@"x"];
        currentCoordinate.y = [results intForColumn:@"y"];
        return currentCoordinate;
    }
    return _errorCoordinate;
}




@end
