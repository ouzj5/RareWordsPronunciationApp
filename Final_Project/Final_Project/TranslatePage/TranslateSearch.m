//
//  TranslateSearch.m
//  Final_Project
//
//  Created by mzq on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateSearch.h"
#import "ResultPage.h"
#import "../TransLogPage/LogController.h"
#import "../TransLogPage/Record.h"
#import <ShowAPI_SDK/ShowAPIRequest.h>
#import <CommonCrypto/CommonDigest.h>

@interface TranslateSearch()
<UITextFieldDelegate>
@end

@implementation TranslateSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _q = @"You are so handsome!";
    _from = @"en";
    _to = @"zh";
    _appid = @"20191218000367459";
    _apppwd = @"8yg2P76i111bhQ9mTQBV";
    _salt = @"329292388938948";
    _dataArray = @[@"中文", @"英语", @"日语", @"韩语", @"法语", @"德语", @"繁体中文",@"自动检测"];
    _languageArray = @[@"zh", @"en", @"jp", @"kor", @"fra", @"de", @"cht", @"auto"];
    _flagsArray = @[@"China.png",@"America.png",@"Japan.png",@"Korea.png",@"France.png",@"Germany.png",@"China.png",@"Auto.png"];
    _button_num1 = 1;
    _button_num2 = 0;
    _record = [[Record alloc]initWithType:0];
    _record.input_prefix = @"原文：";
    _record.output_prefix = @"翻译结果：";
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    UIColor *bg = [UIColor colorWithRed:216/255.0 green:65/255.0 blue:77/255.0 alpha:1];
    UIColor *textbg = [UIColor colorWithRed:124/255.0 green:125/255.0 blue:127/255.0 alpha:0.3];
    
    _draw = [[DrawTranslate alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, width, height)];
    [self.view addSubview:_draw];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    UIImage *image = [self createAImageWithColor:[UIColor clearColor] alpha:0.0];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setHidden:YES];
    
    UILabel *trans_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.bounds.size.height, width, 90)];
    trans_title.text = @"在线翻译";
    trans_title.textColor = [UIColor whiteColor];
    trans_title.textAlignment = NSTextAlignmentCenter;
    trans_title.font = [UIFont boldSystemFontOfSize:40.0f];
    trans_title.backgroundColor = bg;
    [self.view addSubview:trans_title];
    
    UIImageView *title_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width-130, self.navigationController.navigationBar.bounds.size.height+15, 32, 32)];
    title_imageView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    title_imageView.image = [UIImage imageNamed:@"search2.png"];
    [self.view addSubview:title_imageView];
    
    _button1 = [[UIButton alloc]initWithFrame:CGRectMake(width/2-30-150, 150, 150, 60)];
    _button1.backgroundColor = textbg;
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_button1 addTarget:self action:@selector(handle_button_1:) forControlEvents:UIControlEventTouchDown];
    _button1.layer.cornerRadius = 10.0f;
    [_button1 setTitle:@"英文" forState:UIControlStateNormal];
    [self.view addSubview:_button1];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 238, width/2 + 50, 12)];
    line1.backgroundColor = bg;
    [self.view addSubview:line1];
    
    UIButton *sumbit_button = [[UIButton alloc]initWithFrame:CGRectMake(width/2 + 50 + 30, 226, 70, 36)];
    [sumbit_button setTitle:@"提交" forState:UIControlStateNormal];
    sumbit_button.backgroundColor = bg;
    sumbit_button.titleLabel.textColor = [UIColor whiteColor];
    sumbit_button.layer.cornerRadius = 9.0f;
    [sumbit_button addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:sumbit_button];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-30+14, 150+14, 32, 32)];
    imageView.image = [UIImage imageNamed:@"translate1.png"];
    [self.view addSubview:imageView];
    
    _button2 = [[UIButton alloc]initWithFrame:CGRectMake(width/2+30, 150, 150, 60)];
    _button2.backgroundColor = textbg;
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_button2 addTarget:self action:@selector(handle_button_2:) forControlEvents:UIControlEventTouchDown];
    _button2.layer.cornerRadius = 10.0f;
    [_button2 setTitle:@"中文" forState:UIControlStateNormal];
    [self.view addSubview:_button2];
    
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(width/2-30-150, 210, 150, 0) style:UITableViewStylePlain];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    //    [self.view addSubview:_tableView1];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(width/2+30, 210, 150, 0) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    //    [self.view addSubview:_tableView2];
    
    _tabelView_data1 = _tableView1;
    _tabelView_data2 = _tableView2;
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(30, 270, width-60, 150)];
    // 设置输入框界面风格,枚举如下:
    // UITextBorderStyleNone        // 无风格
    // UITextBorderStyleLine        // 线性风格
    // UITextBorderStyleBezel       // bezel风格
    // UITextBorderStyleRoundedRect // 边框风格
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
    _textField.enabled = YES;
    _textField.textColor = [UIColor blackColor];
    _textField.selected = YES;
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.borderWidth = 1.0f;
    _textField.placeholder = @"请输入要翻译的原文";
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(width - (width/2 + 100), 440, width/2+100, 12)];
    line2.backgroundColor = bg;
    [self.view addSubview:line2];
    
    // 设置提示文字
    // 将控件添加到当前视图上
    _textField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_textField];
    [self.view addSubview:_tableView1];
    [self.view addSubview:_tableView2];
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(30, 500, width-60, 250)];
    _textView.backgroundColor = textbg;
    _textView.layer.cornerRadius = 10.f;
    _textView.editable = NO;
    _textView.text = _getDic[@"trans_result"][0][@"dst"];
    _textView.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:_textView];
    
    UIImageView *bottom_image_1 = [[UIImageView alloc]initWithFrame:CGRectMake(((width / 3) - 35) / 2, height - 85 + 25, 40, 40)];
    bottom_image_1.image = [UIImage imageNamed:@"fanhui.png"];
    
    UIImageView *bottom_image_2 = [[UIImageView alloc]initWithFrame:CGRectMake(width-62, height-63, 40, 40)];
    bottom_image_2.image = [UIImage imageNamed:@"history.png"];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [bottom_image_1 addGestureRecognizer:tap1];
    bottom_image_1.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to_history)];
    [bottom_image_2 addGestureRecognizer:tap2];
    bottom_image_2.userInteractionEnabled = YES;
    
    [self.view addSubview:bottom_image_1];
    [self.view addSubview:bottom_image_2];
    
}

-(void)viewWillAppear:(BOOL)animated{
    _record = [[Record alloc] initWithType: 0];
    [self.navigationController.navigationBar setHidden:YES];
}

-(void)submit{
    [self textFieldShouldReturn:_textField];
}

-(void)to_history{
    MyLogViewController *p = [[MyLogViewController alloc]initWithTitle:@"历史记录" type:0];
    [self.navigationController pushViewController:p animated:NO];
    [self.navigationController.navigationBar setHidden:NO];
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

-(NSString *)stringToMD5:(NSString *)str {
    
    // 1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    // 2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    // 3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /*
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    // 4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    // 5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    // x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
    return saveResult;
    /*
     这里返回的是32位的加密字符串，有时我们需要的是16位的加密字符串，其实仔细观察即可发现，16位的加密字符串就是这个字符串中见的部分。我们只需要截取字符串即可（[saveResult substringWithRange:NSMakeRange(7, 16)]）
     */
}

-(void)handleRequestWithStr{
    NSString *strplus = [_appid stringByAppendingString:[_q stringByAppendingString:[_salt stringByAppendingString:_apppwd]]];
    _sign = [self stringToMD5:strplus];
    //important!
    NSString *change_q = [_q stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *send_str = [NSString stringWithFormat:@"https://api.fanyi.baidu.com/api/trans/vip/translate?q=%@&from=%@&to=%@&appid=%@&salt=%@&sign=%@",change_q,_from,_to,_appid,_salt,_sign];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: self
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:send_str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithRequest:request
                                                             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         if(error == nil)
         {
             //获得的json先转换成字符串
             NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
             //字符串再生成NSData
             NSData * d = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
             //再解析
             NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:d options:NSJSONReadingMutableLeaves error:nil];
             //             NSLog(@"%@",jsonDict[@"trans_result"][0][@"dst"]);
             
             [self->_record addRecord:jsonDict[@"trans_result"][0][@"src"] outcome:jsonDict[@"trans_result"][0][@"dst"]];
             _textView.text = jsonDict[@"trans_result"][0][@"dst"];
         }
     }];
    
    [dataTask resume];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) return NO;
    _q = textField.text;
    _from = _languageArray[_button_num1];
    _to = _languageArray[_button_num2];
    
    [textField resignFirstResponder];
    [self handleRequestWithStr];
    return YES;
}

-(void)handle_button_1:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == NO) {
        _tableView1.frame = CGRectMake(self.view.bounds.size.width/2-30-150, 210, 150, 0);
    }
    else {
        _tableView1.frame = CGRectMake(self.view.bounds.size.width/2-30-150, 210, 150, 240);
    }
}

-(void)handle_button_2:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == NO) {
        _tableView2.frame = CGRectMake(self.view.bounds.size.width/2 + 30, 210, 150, 0);
    }
    else {
        _tableView2.frame = CGRectMake(self.view.bounds.size.width/2 + 30, 210, 150, 240);
    }
}
//
//-(void)handle_submit{
//    _q = _textField.text;
//    NSLog(@"%@",_q);
//    [self handleRequestWithStr];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tabelView_data1){
        [_button1 setTitle:_dataArray[indexPath.section] forState:UIControlStateNormal];
        _tableView1.frame = CGRectMake(20, 360, 200, 0);
        _button1.selected = !_button1.selected;
        _button_num1 = indexPath.section;
    }
    if (tableView == _tabelView_data2){
        [_button2 setTitle:_dataArray[indexPath.section] forState:UIControlStateNormal];
        _tableView2.frame = CGRectMake(160, 360, 200, 0);
        _button2.selected = !_button2.selected;
        _button_num2 = indexPath.section;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    [cell.imageView setImage:[UIImage imageNamed:_flagsArray[indexPath.section]]];
    cell.backgroundColor = [UIColor colorWithRed:124/255.0 green:125/255.0 blue:127/255.0 alpha:0.2];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataArray[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
