
//
//  WaveLoad.m
//  Final_Project
//
//  Created by BlackWhite on 2019/12/28.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaveLoad.h"

@interface WaveLoad()
@end

@implementation WaveLoad

-(void) viewDidLoad {
    WaveView *awave = [WaveView waveViewWithConfig:^(WaveConfig *config) {
        config.position = WavePositionBottom;
        config.bgColor = [UIColor clearColor];
        config.isAnimation = YES;
        config.isShowImage = YES;
        config.waveSpeed = 0.05;
        config.waveA = 10;
        config.waveColor = [UIColor colorWithRed:135.0/255 green:206.0/255 blue:235.0/255 alpha:0.7];
    }];
    _wave = awave;
    _wave.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 150, [UIScreen mainScreen].bounds.size.width, 150);
    [self.view addSubview:_wave];
}




@end
