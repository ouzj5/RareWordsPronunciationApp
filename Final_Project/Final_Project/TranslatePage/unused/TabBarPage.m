//
//  TabBarPage.m
//  Final_Project
//
//  Created by mzq on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TabBarPage.h"

@interface TabBarPage ()

@end

@implementation TabBarPage

-(void)viewDidLoad{
    [super viewDidLoad];
    _p1 = [[TranslateSearch alloc]init];
    _p2 = [[MyLogViewController alloc]initWithTitle:@"翻译记录" type:0];
    
    _p1.tabBarItem.title = @"查询";
    _p2.tabBarItem.title = @"历史记录";
    [_p1.tabBarItem setImage:[UIImage imageNamed:@"search.png"]];
    [_p2.tabBarItem setImage:[UIImage imageNamed:@"record.png"]];
    
    _p1.tabBarItem.imageInsets = UIEdgeInsetsMake(20,-40,-20,40);
    _p2.tabBarItem.imageInsets = UIEdgeInsetsMake(20,-65,-20,65);
    
    //TabBarItem的字体属性
    NSMutableDictionary * fontAttrs = [NSMutableDictionary dictionary];
    fontAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20.0f];  // 设置文字大小
    fontAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];  // 设置文字的前景色
    //设置文字正常下的状态
    [_p1.tabBarItem setTitleTextAttributes:fontAttrs forState:UIControlStateNormal];
    [_p2.tabBarItem setTitleTextAttributes:fontAttrs forState:UIControlStateNormal];
    
    [self addChildViewController:_p1];
    [self addChildViewController:_p2];
    
    self.delegate = (id)self;

}

@end
