//
//  ZDFPlaceDetail.h
//  ZDFLocationTool
//
//  Created by yeyuban on 16/3/23.
//  Copyright © 2016年 oxxther. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LOCATITY @"Locality"
#define SUBLOCATITY @"subLocality"
#define DETAILLOCATITY @"detailLocality"

@interface ZDFPlaceDetail : NSObject <NSCoding>
//市
@property (nonatomic,copy) NSString *locality;
//区
@property (nonatomic,copy) NSString *subLocality;
//详细地址
@property (nonatomic,copy) NSString *detailLocality;

- (instancetype)initWithLocality:(NSString *)locality andSubLocality:(NSString *)subLocality andDetailLocality:(NSString *)detailLocality;

@end
