//
//  ResultPage.h
//  Final_Project
//
//  Created by mzq on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef ResultPage_h
#define ResultPage_h

#import <UIKit/UIKit.h>
#import <YCShadowView/YCShadowView.h>

@interface ResultPage: UIViewController

@property(nonatomic, strong) UILabel *titleText;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;

//@property(nonatomic, strong) YCShadowView *yc1;
//@property(nonatomic, strong) YCShadowView *yc2;
@property(nonatomic, strong) UITextView *textView1;
@property(nonatomic, strong) UITextView *textView2;

@property(nonatomic,strong) NSDictionary *getDic;

-(ResultPage*) initWithDic:(NSDictionary*)dic;

@end


#endif /* ResultPage_h */
