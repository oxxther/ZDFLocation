//
//  ZDFPlaceDetail.m
//  ZDFLocationTool
//
//  Created by yeyuban on 16/3/23.
//  Copyright © 2016年 oxxther. All rights reserved.
//

#import "ZDFPlaceDetail.h"

@implementation ZDFPlaceDetail

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.locality forKey:LOCATITY];
    [aCoder encodeObject:self.subLocality forKey:SUBLOCATITY];
    [aCoder encodeObject:self.detailLocality forKey:DETAILLOCATITY];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [self init]) {
        self.locality = [aDecoder decodeObjectForKey:LOCATITY];
        self.subLocality = [aDecoder decodeObjectForKey:SUBLOCATITY];
        self.detailLocality = [aDecoder decodeObjectForKey:DETAILLOCATITY];
    }
    return self;
}

- (instancetype)initWithLocality:(NSString *)locality andSubLocality:(NSString *)subLocality andDetailLocality:(NSString *)detailLocality{
    if (self = [self init]) {
        self.locality = locality;
        self.subLocality = subLocality;
        self.detailLocality = detailLocality;
    }
    return self;
}
@end
