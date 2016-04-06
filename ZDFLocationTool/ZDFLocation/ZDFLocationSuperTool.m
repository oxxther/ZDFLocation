//
//  ZDFLocationSuperTool.m
//  ZDFLocationTool
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 oxxther. All rights reserved.
//

#import "ZDFLocationSuperTool.h"
#import <UIKit/UIKit.h>



@interface ZDFLocationSuperTool ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,strong)CLGeocoder *geocoder;

@property (nonatomic,copy) MyLocateFinished locateFinish;

@end


@implementation ZDFLocationSuperTool

static ZDFLocationSuperTool* zdfLST = nil;

+ (void)initialize{
    if (self == [self class]) {
        zdfLST = [[self alloc]init];
    }
}

+ (instancetype)sharedZDFLocationSuperTool{
    return zdfLST;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}


- (void)getLocationFinished:(MyLocateFinished)block{
    //判断版本
    [self getLocationBeforeIOS7:[self isBeforeIOS7]];
    self.locateFinish = block;
}

#pragma mark - 定位
- (void)getLocationBeforeIOS7:(BOOL)isBeforeIOS7{
    if (isBeforeIOS7) {
        [self getLocationBeforeIOS7];
    }else{
        [self getLocationAfterIOS7];
    }
}
///ios7以前
- (void)getLocationBeforeIOS7{
    
}
///ios7之后
- (void)getLocationAfterIOS7{
    self.manager = [[CLLocationManager alloc]init];
    
    //提醒用户是否开启定位授权
    [self.manager requestAlwaysAuthorization];
    
    self.manager.delegate = self;
    
    [self.manager startUpdatingLocation];
}



#pragma mark - 实现CLLocationManagerDelegate的方法进行定位
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        //kCLAuthorizationStatusNotDetermined = 0
        //用户未决定时
        case kCLAuthorizationStatusNotDetermined:
            break;
            
        //kCLAuthorizationStatusRestricted = 1
        case kCLAuthorizationStatusRestricted:
            break;
            
        //kCLAuthorizationStatusDenied = 2
        //永不
        case kCLAuthorizationStatusDenied:
            break;
            
        //kCLAuthorizationStatusAuthorizedAlways = 3
        //始终
        case kCLAuthorizationStatusAuthorizedAlways:
            [self realLocation];
            break;
            
        //kCLAuthorizationStatusAuthorizedWhenInUse = 4
        //用户允许在使用期间定位(前台)
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self realLocation];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
#warning 定位的具体实现
    if (locations.count > 1) {
        //拿到具体地址
        CLLocation *location = [locations lastObject];
        //反地理编码
        [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = [placemarks lastObject];
            //实例出自定义的对象.
            ZDFPlaceDetail *place = [[ZDFPlaceDetail alloc]initWithLocality:placemark.locality andSubLocality:placemark.subLocality andDetailLocality:placemark.name];
            self.locateFinish(place);
        }];
    }
}



///定位出错时调用
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
}

///授权完真正开始定位
- (void)realLocation{
    //设定定位精确度
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //移动间距设定
    self.manager.distanceFilter = 10.f;
    //开始定位操作
    [self.manager startUpdatingLocation];
}

#pragma mark - 判断版本
- (BOOL)isBeforeIOS7{
    UIDevice *device = [UIDevice currentDevice];
    //判断版本
    if([device.systemVersion doubleValue] > 7.){
        //进行用户定位授权确定界面
        return NO;
    }else{
        //直接默认开启定位
        return YES;
    }
}
@end
