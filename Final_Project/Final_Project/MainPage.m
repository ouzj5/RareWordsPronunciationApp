//
//  MainPage.m
//  Final_Project
//
//  Created by mzq on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainPage.h"
#import "TranslatePage/TranslateSearch.h"
#import "./RarelyUsedWordPage/RarelyUsedWordPageController.h"
#import "./RarelyUsedWordPage/QueryResultPage.h"
#import "./PinYinPage/Layout/PinYinPage.h"
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0  green:(((s & 0xFF00) >> 8))/255.0  blue:((s & 0xFF))/255.0  alpha:1.0]

@interface MainPage()

@end

@implementation MainPage

-(void)viewDidLoad{
    [super viewDidLoad];
//    CGFloat height = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    UIFont *textfont = [UIFont boldSystemFontOfSize:35.f];
    
    UIImage *title= [UIImage imageNamed:@"titlepng.png"];
    //UIImage *back = [self createAImageWithColor:[UIColor blackColor] alpha:0.5];
    UIImageView *vtitle= [[UIImageView alloc]initWithImage:title];
    vtitle.frame=CGRectMake(30, 80, width-60, 160);
    [self.view addSubview:vtitle];
    
    _b1 = [[UIButton alloc]initWithFrame:CGRectMake(width/2 - 150, 250 + 80, 300, 80)];
    [_b1 setTitle:@"在线翻译" forState:UIControlStateNormal];
    _b1.layer.cornerRadius = 10.0f;
    _b1.backgroundColor =  [UIColor colorWithRed:216/255.0 green:65/255.0 blue:77/255.0 alpha:1];
//    [_b1 setImage:[UIImage imageNamed:@"fanyi1.png"] forState:UIControlStateNormal];
    [_b1 addTarget:self action:@selector(handle_one) forControlEvents:UIControlEventTouchDown];
    UIImageView *u1 = [[UIImageView alloc]initWithFrame:CGRectMake(width/2 -150 +10, 250+80+16, 48, 48)];
    
    _b2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2 - 150, 380 + 80, 300, 80)];
    [_b2 setTitle:@"拼音查询" forState:UIControlStateNormal];
    _b2.layer.cornerRadius = 10.0f;
    _b2.backgroundColor = [UIColor colorWithRed:0.18 green:0.55 blue:0.36 alpha:1];
//    [_b2 setImage:[UIImage imageNamed:@"pinyin1.png"] forState:UIControlStateNormal];
    [_b2 addTarget:self action:@selector(handle_two) forControlEvents:UIControlEventTouchDown];
    UIImageView *u2 = [[UIImageView alloc]initWithFrame:CGRectMake(width/2 -150 +10, 380+80+16, 48, 48)];
    
    _b3 = [[UIButton alloc]initWithFrame:CGRectMake(width/2 - 150, 510 + 80, 300, 80)];
    [_b3 setTitle:@"生僻字查询" forState:UIControlStateNormal];
    _b3.layer.cornerRadius = 10.0f;
    _b3.backgroundColor = UIColorFromHex(0x439bf2);
//    [_b3 setImage:[UIImage imageNamed:@"shengpi.png"] forState:UIControlStateNormal];
    [_b3 addTarget:self action:@selector(handle_three) forControlEvents:UIControlEventTouchDown];
    UIImageView *u3 = [[UIImageView alloc]initWithFrame:CGRectMake(width/2 -150 +10, 510+80+16, 48, 48)];
    
    _b1.titleLabel.font = _b2.titleLabel.font = _b3.titleLabel.font = textfont;
    _b1.titleLabel.textColor = _b2.titleLabel.textColor = _b3.titleLabel.textColor = [UIColor blackColor];
    u1.image = [UIImage imageNamed:@"fanyi1.png"];
    u2.image = [UIImage imageNamed:@"pinyin1.png"];
    u3.image = [UIImage imageNamed:@"shengpi.png"];
    u1.backgroundColor = u2.backgroundColor = u3.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    
    [self.view addSubview:_b1];
    [self.view addSubview:_b2];
    [self.view addSubview:_b3];
    
    [self.view addSubview: u1];
    [self.view addSubview: u2];
    [self.view addSubview: u3];

    ///////////
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

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)handle_one{
    TranslateSearch *t = [[TranslateSearch alloc]init];
    [self.navigationController pushViewController:t animated:NO];
}

-(void)handle_two{
    PinYinPage *pinyinpage = [[PinYinPage alloc] init];
    [self.navigationController pushViewController:pinyinpage animated:NO];
}

-(void)handle_three{
    RarelyUsedWordPageController *page=[[RarelyUsedWordPageController alloc]init];
    [self.navigationController pushViewController:page animated:NO];
}

@end
