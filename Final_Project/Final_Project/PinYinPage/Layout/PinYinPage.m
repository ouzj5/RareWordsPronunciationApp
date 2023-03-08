//
//  PinYinPage.m
//  Final_Project
//
//  Created by BlackWhite on 2019/12/18.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PinYinPage.h"
#import "../../TransLogPage/LogController.h"
@interface PinYinPage()<UINavigationControllerDelegate, UITextFieldDelegate>
@end

@implementation PinYinPage
-(void)viewDidLoad {
    //[self viewWillDisappear: false];
    //[super viewDidLoad];
    
    _record = [[Record alloc]initWithType:2];
    _record.input_prefix = @"词语：";
    _record.output_prefix = @"拼音：";

    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    UIImage *image = [self createAImageWithColor:[UIColor clearColor] alpha:0.0];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setHidden:YES];
    
    DrawPinYin *draw = [[DrawPinYin alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:draw];
    
    
    //add fanhui icon
    UIImage *back= [UIImage imageNamed:@"fanhui.png"];
    //UIImage *back = [self createAImageWithColor:[UIColor blackColor] alpha:0.5];
    UIImageView *backView= [[UIImageView alloc]initWithImage:back];
    backView.frame=CGRectMake(((self.view.frame.size.width / 3) - 35) / 2, self.view.frame.size.height - 85 + 25, 40, 40);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [backView addGestureRecognizer:tap];
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    
    //add history
    UIImage *log= [UIImage imageNamed:@"history.png"];
    //UIImage *back = [self createAImageWithColor:[UIColor blackColor] alpha:0.5];
    UIImageView *logView= [[UIImageView alloc]initWithImage:log];
    logView.frame=CGRectMake(self.view.frame.size.width - 100 + 38, self.view.frame.size.height - 85 + 22, 40, 40);
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(log)];
    [logView addGestureRecognizer:tap2];
    logView.userInteractionEnabled = YES;
    [self.view addSubview:logView];
    
    //self
    [self inputAndOutputView];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}

-(void)log {
    MyLogViewController *p = [[MyLogViewController alloc]initWithTitle:@"历史记录" type:2];
    [self.navigationController pushViewController:p animated:NO];
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    _record = [[Record alloc] initWithType: 2];
    _record.input_prefix = @"词语：";
    _record.output_prefix = @"拼音：";
    [self.navigationController.navigationBar setHidden:YES];
}
// cover the navigation
- (UIImage *)createAImageWithColor:(UIColor *)color alpha:(CGFloat)alpha{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_text resignFirstResponder];
}

-(void) inputAndOutputView {
    
    _button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _button1.frame=CGRectMake(self.view.frame.size.width/2 - 40, self.view.frame.size.height - 130, 80, 40);//按钮的位置坐标
    [_button1 setTitle:@"拼 音" forState:UIControlStateNormal];//高亮状态的按钮标题
    _button1.layer.cornerRadius = _button1.frame.size.height / 4;
    
    //高亮状态光晕效果
    //[_button1 setShowsTouchWhenHighlighted:YES];
    //设置标题的颜色
    [_button1 setBackgroundColor:[UIColor colorWithRed:0.18 green:0.55 blue:0.36 alpha:1]];
    [_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置标题的字体大小
    [_button1.titleLabel setFont:[UIFont boldSystemFontOfSize:27]];
    [_button1  addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventTouchUpInside];
    
    //input character text
    _text = [[UITextField alloc]initWithFrame:CGRectMake(20, 155 + 45, self.view.frame.size.width - 18 - 18, 300 - 3 - 158)];
    _text.borderStyle = UITextBorderStyleRoundedRect;
    _text.backgroundColor= UIColor.clearColor;
    _text.text = @"";
    _text.placeholder = @"请输入查询词语（支持4字以下词语）";
    _text.font = [UIFont systemFontOfSize:20];
    _text.clearsOnBeginEditing = YES;
    [_text addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchDown];
    
    //output sub character
    _textSub1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 385 + 45, 120, 120)];
    _textSub2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, 385 + 45, 120, 120)];
    _textSub3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 580 + 45, 120, 120)];
    _textSub4 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, 580 + 45, 120, 120)];
    _textSub1.font = _textSub2.font = _textSub3.font = _textSub4.font = [UIFont boldSystemFontOfSize: 95];
    _textSub1.textAlignment = _textSub2.textAlignment = _textSub3.textAlignment = _textSub4.textAlignment = NSTextAlignmentCenter;
    
    //output sub pinyin
    _pin1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 385 - 7, 120, 50)];
    _pin2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, 385 - 7, 120, 50)];
    _pin3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 580 - 7, 120, 50)];
    _pin4 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 180, 580 - 7, 120, 50)];
    _pin1.font = _pin2.font = _pin3.font = _pin4.font = [UIFont boldSystemFontOfSize: 32];
    _pin1.textAlignment = _pin2.textAlignment = _pin3.textAlignment = _pin4.textAlignment = NSTextAlignmentCenter;
    //[self.view addSubview:_pin1];
    
    [self.view addSubview:_text];
    [self.view addSubview:_button1];
}

-(void)clearText:(UITextView *)text {
    text.text = @"";
}

//文本输入框结束输入时调用
- (void)textFieldDidEndEditing:(UIButton *)btn{
    //btn.selected = !btn.selected;
    //获取当前文本输入框中所输入的文
    //NSLog(@"所输入的内容为:%@", _text.text);
    _pin1.text = _pin2.text = _pin3.text = _pin4.text = @" ";

    for (UIView *myLabelView in [self.view subviews]) {
        if ([myLabelView isKindOfClass:[UILabel class]]) {
            [myLabelView removeFromSuperview];
        }
    }
    [self callPinYinSdk];
    
}

-(void) callPinYinSdk {
    //_yinCount = 0;
    NSString* pinyinWhole = [_text.text stringByTrimmingCharactersInSet:
               [NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"%@",pinyinWhole);
    //这里需要替换为你自己的appid和secret，你可以在这里找到 https://www.showapi.com/console#/myApp  128074
    ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"128074" andSign:@"ad5f2eccc4274d90b5dead932dbfcd6c" ];
    
    
    //调用接口
    [request post:@"https://route.showapi.com/874-1"//注意您需要先订购该接口套餐才能测试
          timeout:20000//超时设置为20秒
           params:[[NSDictionary alloc] initWithObjectsAndKeys:pinyinWhole, @"text",@"0",@"caseType",@"0",@"toneType",@"0",@"vcharType", nil]//传入参数
     
   withCompletion:^(NSDictionary *result) {
       NSObject *search = @"pinyin";
       _pinyingGot = result[@"showapi_res_body"][@"pinyin"];
       //_pinyingGot = [result objectForKey:@"pinyin"];
       NSLog(@"%@", _pinyingGot);
       
       
       NSArray *singleString = [_pinyingGot componentsSeparatedByString:@" "];
       //NSLog(@"%@=",singleString);
       //int l = singleString.count;
       //printf("%d\n",l);
       
       switch (singleString.count) {
           case 4:
               _pin4.text = singleString[3];
           case 3:
               _pin3.text = singleString[2];
           case 2:
               _pin2.text = singleString[1];
           case 1:
               _pin1.text = singleString[0];
               break;
           default:
               NSLog(@"case error");
               break;
       }
       [self.view addSubview:_pin1];
       [self.view addSubview:_pin2];
       [self.view addSubview:_pin3];
       [self.view addSubview:_pin4];
       self -> _yinCount = singleString.count;
       
       NSString* paddingSub = @" ";
       NSString* singleWordMultiYin = _text.text;
       NSString* singleSub[4];
       unsigned long subIndex = 0;
       for (unsigned long i = 0; i * _text.text.length < self -> _yinCount && i * _text.text.length < 4 && i < 4; i ++) {
           //_text.text = [_text.text stringByAppendingFormat:@"%@", paddingSub];
           for (unsigned long j = 0; j < singleWordMultiYin.length; j ++) {
               singleSub[i * _text.text.length + j] = [_text.text substringWithRange:NSMakeRange(j, 1)];
               subIndex = i * _text.text.length + j;
           }
       }
       
       for (unsigned long i = subIndex + 1; i < 4; i ++) {
           singleSub[i] = @" ";
       }

       _textSub1.text = singleSub[0];
       _textSub2.text = singleSub[1];
       _textSub3.text = singleSub[2];
       _textSub4.text = singleSub[3];
       
       [self.view addSubview:_textSub1];
       [self.view addSubview:_textSub2];
       [self.view addSubview:_textSub3];
       [self.view addSubview:_textSub4];
       
       [self->_record addRecord:_text.text outcome:result[@"showapi_res_body"][@"pinyin"]];
   }];
    //return _yinCount;
}
@end
