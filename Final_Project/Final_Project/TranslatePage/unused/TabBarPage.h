//
//  TabBarPage.h
//  Final_Project
//
//  Created by mzq on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef TabBarPage_h
#define TabBarPage_h

#import <UIKit/UIKit.h>
#import "TranslateSearch.h"
#import "LogController.h"

@interface TabBarPage : UITabBarController

@property(nonatomic,strong) TranslateSearch *p1;
@property(nonatomic,strong) MyLogViewController *p2;

@property(nonatomic) NSString *str1;
@property(nonatomic) NSString *str2;

@end


#endif /* TabBarPage_h */
