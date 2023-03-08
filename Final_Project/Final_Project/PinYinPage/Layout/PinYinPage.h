//
//  PinYinPage.h
//  Final_Project
//
//  Created by BlackWhite on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef PinYinPage_h
#define PinYinPage_h
#import <QuartzCore/QuartzCore.h>
#import <ShowAPI_SDK/ShowAPIRequest.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import "../../TransLogPage/Record.h"
#import "DrawPinYin.h"
@interface PinYinPage : UIViewController<UINavigationControllerDelegate>
@property (assign)NSString *characterRequired;
@property (assign)NSString *pinyingGot;
@property (strong)DrawPinYin *draw;
@property (strong, nonatomic) UITextField *text;
@property (strong, nonatomic) UIButton *button1;

@property (strong, nonatomic) UILabel *textSub1;
@property (strong, nonatomic) UILabel *textSub2;
@property (strong, nonatomic) UILabel *textSub3;
@property (strong, nonatomic) UILabel *textSub4;

@property (strong, nonatomic) UILabel *pin1;
@property (strong, nonatomic) UILabel *pin2;
@property (strong, nonatomic) UILabel *pin3;
@property (strong, nonatomic) UILabel *pin4;

@property (assign) NSUInteger yinCount;
@property(nonatomic, strong) __block Record *record;


@end

#endif /* PinYinPage_h */
