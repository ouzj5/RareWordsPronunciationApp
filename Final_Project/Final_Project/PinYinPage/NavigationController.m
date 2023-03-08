//
//  NavigationController.m
//  Final_Project
//
//  Created by BlackWhite on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationController.h"
#import "PinyinTarBarController.h"
@interface NavigationController() <UINavigationControllerDelegate>

@end

@implementation NavigationController

-(void)viewDidLoad{
    printf("@33");
    //self.navigationController.navigationBar.subviews[0].alpha = 0;
    [super viewDidLoad];
    //[self addChildViewController:self.mainview];
    
}

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果进入的是当前视图控制器
    //if (viewController == self) {
    if(true){
        // 背景设置为黑色
        printf("@ff");
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:1.000];
        // 透明度设置为0.3
        self.navigationController.navigationBar.alpha = 0.1;
        // 设置为半透明
        //self.navigationController.navigationBar.translucent = YES;
    } else {
        // 进入其他视图控制器
        self.navigationController.navigationBar.alpha = 1;
        // 背景颜色设置为系统默认颜色
        self.navigationController.navigationBar.tintColor = nil;
        self.navigationController.navigationBar.translucent = NO;
    }
}

@end
