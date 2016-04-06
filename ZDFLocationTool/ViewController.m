//
//  ViewController.m
//  ZDFLocationTool
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 oxxther. All rights reserved.
//

#import "ViewController.h"
#import "ZDFLocationSuperTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[ZDFLocationSuperTool sharedZDFLocationSuperTool] getLocationFinished:^(ZDFPlaceDetail *place) {
        NSLog(@"%@",place);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
