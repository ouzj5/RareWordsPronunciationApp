//
//  TarBarController.h
//  Final_Project
//
//  Created by BlackWhite on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef PinyinTarBarController_h
#define PinyinTarBarController_h
#import <UIKit/UIKit.h>

@interface PinyinTarBarController : UITabBarController
//@property (nonatomic,strong) UITabBarController *tabBar;
@property (nonatomic)NSString *str1;
-(void)initWithTitle:(NSString*) str;
@end

#endif /* TarBarController_h */
