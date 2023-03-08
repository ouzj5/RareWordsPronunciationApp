
//
//  WaveLoad.m
//  Final_Project
//
//  Created by BlackWhite on 2019/12/28.
//  Copyright © 2019 mzq. All rights reserved.
//

#import "WaveConfig.h"

@implementation WaveConfig
+ (instancetype)defaultConfig
{
    WaveConfig *config = [[WaveConfig alloc] init];
    config.bgColor = [UIColor redColor];
    config.waveColor = [UIColor greenColor];
    config.waveSpeed = 0.1;   //  速度
    config.waveA = 20;    //  振幅
    config.wavePeriod = 1/30.0;  //  周期
    config.waveOffset = 0.0;  //  设置横向偏移
    config.waveC = config.waveA*2;   // 纵向位置
    config.position = WavePositionBottom;
    config.isAnimation = YES;
    config.isShowImage = NO;
    config.imgSize = CGSizeMake(20, 20);
    return config;
}
@end
