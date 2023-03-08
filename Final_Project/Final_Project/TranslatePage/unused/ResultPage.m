//
//  ResultPage.m
//  Final_Project
//
//  Created by mzq on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResultPage.h"

@interface ResultPage ()
<UITabBarDelegate>
@end

@implementation ResultPage

-(ResultPage*) initWithDic:(NSDictionary*)dic{
    if (self == nil){
        self = [ResultPage alloc];
    }
    _getDic = dic;
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UIColor *bg = [UIColor colorWithRed:127/255.0 green:244/255.0 blue:240/255.0 alpha:0.3];
    UIColor *labelbg = [UIColor colorWithRed:42/255.0 green:252/255.0 blue:130/255.0 alpha:0.8];
    
    self.title = @"Translate Result";
    
    _textView1 = [[UITextView alloc]initWithFrame:CGRectMake(20, 50, width-40, height/2 - 100)];
    _textView1.backgroundColor = bg;
    _textView1.layer.cornerRadius = 10.f;
    _textView1.text = _getDic[@"trans_result"][0][@"dst"];
    _textView1.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:_textView1];
    
    _textView2 = [[UITextView alloc]initWithFrame:CGRectMake(20, height/2, width-40, height/2-100)];
    _textView2.backgroundColor = bg;
    _textView2.layer.cornerRadius = 10.f;
    _textView2.text = _getDic[@"trans_result"][0][@"src"];
    _textView2.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:_textView2];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, width/2-100, 30)];
    _label1.text = @"翻译结果";
//    _label1.font = [UIFont boldSystemFontOfSize:20.0f];
    _label1.backgroundColor = labelbg;
    _label1.textAlignment = NSTextAlignmentCenter;
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2-30, width/2-100, 30)];
    _label2.text = @"您的输入";
//    _label2.font = [UIFont boldSystemFontOfSize:20.0f];
    _label2.backgroundColor = labelbg;
    _label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label1];
    [self.view addSubview:_label2];
}
@end
