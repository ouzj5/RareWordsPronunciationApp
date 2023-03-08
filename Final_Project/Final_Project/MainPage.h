//
//  MainPage.h
//  Final_Project
//
//  Created by mzq on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef MainPage_h
#define MainPage_h

#import <UIKit/UIKit.h>
#import "WaveView/WaveView.h"

@interface MainPage : UIViewController

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *b1;
@property (nonatomic,strong) UIButton *b2;
@property (nonatomic,strong) UIButton *b3;
@property (nonatomic, weak) WaveView *wave;

@end

#endif /* MainPage_h */
