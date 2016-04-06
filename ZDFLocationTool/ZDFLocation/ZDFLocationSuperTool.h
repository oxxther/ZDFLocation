//
//  ZDFLocationSuperTool.h
//  ZDFLocationTool
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 oxxther. All rights reserved.
//


/*这个类是使用iPhone自带的类进行定位功能
 *首先,根据不同iOS版本来进行定位授权
 *其次,确定位子后,把位置进行相应处理输出
 *最后,在确定位置后,我可以能够把要实现的代码功能写入其中
 */
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ZDFPlaceDetail.h"

#warning 以后改进
typedef void(^MyLocateFinished)(ZDFPlaceDetail *place);

@interface ZDFLocationSuperTool : NSObject

+ (instancetype)sharedZDFLocationSuperTool;

//定位,其实可以用一个类方法来实现
- (void)getLocationFinished:(MyLocateFinished)block;

@end
