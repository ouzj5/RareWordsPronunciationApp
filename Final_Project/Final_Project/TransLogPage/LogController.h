//
//  MyTabBarController.h
//  hw3
//
//  Created by 区梓俊 on 2019/10/6.
//  Copyright © 2019 区梓俊. All rights reserved.
//
#import <UIKit/UIKit.h>

/*
 记录列表页面
 */
#ifndef MyTableViewController_h
#define MyTableViewController_h
@interface MyLogViewController : UIViewController

//初始化，给出记录的title，type为记录类型，数字为页面索引(0, 1, 2)
//记录类型与添加记录的类型匹配
- (id)initWithTitle:(NSString *) title type:(NSInteger) type;
@end

#endif /* MyTableViewController_h */
