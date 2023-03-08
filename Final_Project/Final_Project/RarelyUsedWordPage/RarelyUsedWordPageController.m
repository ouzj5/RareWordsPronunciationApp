//
//  RarelyUsedWordPageController.m
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/18.
//  Copyright © 2019年 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RarelyUsedWordPageController.h"
#import "worldbottom.h"
#import "LMJDropdownMenu.h"
#import "InputCell.h"
#import "QueryResultPage.h"
#import "../MainPage.h"
#import <ShowAPI_SDK/ShowAPIRequest.h>
#import "NewLayout.h"
#import "../TransLogPage/LogController.h"
#import "../TransLogPage/Record.h"

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0  green:(((s & 0xFF00) >> 8))/255.0  blue:((s & 0xFF))/255.0  alpha:1.0]

@interface  RarelyUsedWordPageController()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation RarelyUsedWordPageController
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
    self.view.backgroundColor=[UIColor clearColor];
    NewLayout *draw = [[NewLayout alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:draw];
    
//    [self lazytitlelabel];
    [self lazytitlelabel1];
//    [self lazytextlabel1];
//    [self lazytextlabel2];
    [self lazytextlabel3];
    [self lazytextlabel4];
   
    self.count=3;
    UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
    Layout.minimumLineSpacing=10;
    Layout.minimumInteritemSpacing=10;
    Layout.itemSize=CGSizeMake( 300/self.count, 300/self.count);
    CGFloat width=self.view.frame.size.width;
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(25,500,width-50,100) collectionViewLayout:Layout];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.scrollEnabled=NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[InputCell class] forCellWithReuseIdentifier:@"cell"];
    
    UIButton *query= [[UIButton alloc]initWithFrame:CGRectMake((width-100)/2, 700, 100, 50)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.colors = @[(__bridge id) UIColorFromHex(0x439bf2).CGColor,(__bridge id)UIColorFromHex(0x439bf2).CGColor];
    //设置渐变的方向
    //(0,0)->(1,0)从左往右
    //(0,0)->(0,0)从上往下
    grad.startPoint = CGPointMake(0, 0);
    grad.endPoint = CGPointMake(1, 1);
    grad.cornerRadius=10;
    //设置渐变的起始位置 (从哪个点开始渐变到下一个颜色)
    // 设置不透明
    grad.frame=query.bounds;
    [query.layer addSublayer:grad];
    [query setTitle:@"查询" forState:UIControlStateNormal];
    [query setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [query addTarget:self action:@selector(queryResult) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:query];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray *array= [self.collectionView visibleCells];
    for(int i=0;i<array.count;i++){
        InputCell *cell=[array objectAtIndex:i];
        [cell.content resignFirstResponder];
    }
}
-(void)queryResult{
    if(self.loading!=nil){
        [self.loading removeFromSuperview];
    }
    UIImage *load= [UIImage imageNamed:@"loadingspinner.png"];
    self.loading= [[UIImageView alloc]initWithImage:load];
    
    self.loading.frame=CGRectMake((self.view.frame.size.width-50)/2, 650, 30, 30);
    [self.view addSubview:self.loading];
    if(self.count==3){
        InputCell *cell1=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        NSString *str1=cell1.content.text;
        InputCell *cell2=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
        NSString *str2=cell2.content.text;
        InputCell *cell3=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
        NSString *str3=cell3.content.text;
        if([str1 isEqualToString:@""]||[str2 isEqualToString:@""]||[str3 isEqualToString:@""]){
            if(self.resultFalse!=nil){
                [self.resultFalse removeFromSuperview];
            }
            self.resultFalse= [[UILabel alloc]initWithFrame:CGRectMake(0, 750, self.view.frame.size.width, 30)];
            [self.resultFalse setText:@"参数不全"];
            if(self.loading!=nil){
                [self.loading removeFromSuperview];
            }
            self.resultFalse.textAlignment=NSTextAlignmentCenter;
                [self.resultFalse setTextColor:[UIColor redColor]];
            [self.view addSubview:self.resultFalse];
        }else{
            [self.resultFalse removeFromSuperview];
            NSLog(@"%@,%@,%@123",str1,str2,str3);
            
            //调用api
             NSString *compose=[[NSString alloc]initWithFormat:@"%@+%@+%@", str1, str2,str3];
            self.query=compose;
            
            ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"129513" andSign:@"633616f17cd741baaf7118063596f163" ];
            [request post:@"https://route.showapi.com/905-1"//注意您需要先订购该接口套餐才能测试
                  timeout:20000//超时设置为20秒
                   params:[[NSDictionary alloc] initWithObjectsAndKeys:compose,@"parts", nil]//传入参数
           withCompletion:^(NSDictionary *result) {
               //打印返回结果
               NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
               // NSData转为NSString
              // NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
               
               self.content = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *content1= [self.content objectForKey:@"showapi_res_body"];
               self.content2=[content1 objectForKey:@"words"];
               self.number=self.content2.count;
               NSLog(@"%ld",self.number);
               NSDictionary *content3= [self.content2 objectAtIndex:0];
               NSString *resultword=[content3 objectForKey:@"word"];
               //
               NSString *strresult= [[NSString alloc]initWithFormat:@""];
               NSUInteger cont=self.content2.count;
               if(cont>=9){
                   cont=9;
               }
               for(int i=0;i<cont;i++){
                   NSDictionary* contentx= [self.content2 objectAtIndex:i];
                   
                   NSString *res11= [contentx objectForKey:@"pinyin"];
                   NSString *res22= [contentx objectForKey:@"word"];
                   strresult= [[NSString alloc]initWithFormat:@"%@ %@, %@\n",strresult,res22,res11];
                   NSLog(@"%@",strresult);
               }
               
               
               
               
               self.result = strresult;
               NSString *resultpinyin=[content3 objectForKey:@"pinyin"];
               NSLog(@"返回结果为：%@,%@",resultword,resultpinyin);
               if(self.number!=0){
                   if(self.loading!=nil){
                       [self.loading removeFromSuperview];
                   }
                   NSArray *queryArray= [[NSArray alloc]initWithObjects:str1,str2,str3, nil];
                   Record *record= [[Record alloc]initWithType:1];
                   [record addRecord:self.query outcome:self.result];
                   QueryResultPage *page= [[QueryResultPage alloc]initWithNumber:self.number dictionary:self.content2 queryArray:queryArray history:self.p];
                   [self.navigationController pushViewController:page animated:YES];
               }else{
                   if(self.resultFalse!=nil){
                       [self.resultFalse removeFromSuperview];
                   }
                   self.resultFalse= [[UILabel alloc]initWithFrame:CGRectMake(0, 750, self.view.frame.size.width, 30)];
                   [self.resultFalse setText:@"没有符合条件的结果"];
                   if(self.loading!=nil){
                       [self.loading removeFromSuperview];
                   }
                   self.resultFalse.textAlignment=NSTextAlignmentCenter;
                   [self.resultFalse setTextColor:[UIColor redColor]];
                   [self.view addSubview:self.resultFalse];
               }
           }];
        }
    }else{
        InputCell *cell1=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        NSString *str1=cell1.content.text;
        InputCell *cell2=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
        NSString *str2=cell2.content.text;
        InputCell *cell3=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
        NSString *str3=cell3.content.text;
        InputCell *cell4=(InputCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
        NSString *str4=cell4.content.text;
        if([str1 isEqualToString:@""]||[str2 isEqualToString:@""]||[str3 isEqualToString:@""]||[str4 isEqualToString:@""]){
            if(self.resultFalse!=nil){
                [self.resultFalse removeFromSuperview];
            }
            self.resultFalse= [[UILabel alloc]initWithFrame:CGRectMake(0, 750, self.view.frame.size.width, 30)];
            [self.resultFalse setText:@"参数不全"];
            if(self.loading!=nil){
                [self.loading removeFromSuperview];
            }
            self.resultFalse.textAlignment=NSTextAlignmentCenter;
            [self.resultFalse setTextColor:[UIColor redColor]];
            [self.view addSubview:self.resultFalse];
        }else{
            [self.resultFalse removeFromSuperview];
            NSLog(@"%@,%@,%@,%@123",str1,str2,str3,str4);
            //调用api
            ShowAPIRequest *request=[[ShowAPIRequest alloc] initWithAppid:@"129513" andSign:@"633616f17cd741baaf7118063596f163" ];
            NSString *compose=[[NSString alloc]initWithFormat:@"%@+%@+%@+%@", str1, str2,str3,str4];
            self.query=compose;
            [request post:@"https://route.showapi.com/905-1"//注意您需要先订购该接口套餐才能测试
                  timeout:20000//超时设置为20秒
             
                  params:[[NSDictionary alloc] initWithObjectsAndKeys:compose,@"parts", nil]//传入参数
           withCompletion:^(NSDictionary *result) {
               //打印返回结果
               NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
               // NSData转为NSString
               // NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]
               
               
               self.content = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
               NSDictionary *content1= [self.content objectForKey:@"showapi_res_body"];
               self.content2=[content1 objectForKey:@"words"];
               self.number=self.content2.count;
               NSLog(@"%ld",self.number);
               NSDictionary *content3= [self.content2 objectAtIndex:0];
               NSString *resultword=[content3 objectForKey:@"word"];
            
               NSString *strresult= [[NSString alloc]initWithFormat:@""];
               NSUInteger cont=self.content2.count;
               if(cont>=9){
                   cont=9;
               }
               for(int i=0;i<cont;i++){
                   NSDictionary* contentx= [self.content2 objectAtIndex:i];
                   
                   NSString *res11= [contentx objectForKey:@"pinyin"];
                   NSString *res22= [contentx objectForKey:@"word"];
                   strresult= [[NSString alloc]initWithFormat:@"%@ %@, %@\n",strresult,res22,res11];
                   NSLog(@"%@",strresult);
               }
               
               
               
               
               self.result = strresult;
               NSString *resultpinyin=[content3 objectForKey:@"pinyin"];
               NSLog(@"返回结果为：%@,%@",resultword,resultpinyin);
               if(self.number!=0){
                   if(self.loading!=nil){
                       [self.loading removeFromSuperview];
                   }
                   Record *record= [[Record alloc]initWithType:1];
                   [record addRecord:self.query outcome:self.result];
                   NSArray *queryArray= [[NSArray alloc]initWithObjects:str1,str2,str3,str4, nil];
                   QueryResultPage *page= [[QueryResultPage alloc]initWithNumber:self.number dictionary:self.content2 queryArray:queryArray history:self.p];
                   [self.navigationController pushViewController:page animated:YES];
               }else{
                   if(self.resultFalse!=nil){
                       [self.resultFalse removeFromSuperview];
                   }
                   self.resultFalse= [[UILabel alloc]initWithFrame:CGRectMake(0, 750, self.view.frame.size.width, 30)];
                   [self.resultFalse setText:@"没有符合条件的结果"];
                   if(self.loading!=nil){
                       [self.loading removeFromSuperview];
                   }
                   self.resultFalse.textAlignment=NSTextAlignmentCenter;
                   [self.resultFalse setTextColor:[UIColor redColor]];
                   [self.view addSubview:self.resultFalse];
               }
           }];
        }
    }
}




//Collection Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.count;
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    InputCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //background
    if(cell.image!=nil){
        [cell.image removeFromSuperview];
        cell.image=nil;
    }
    if(cell.content!=nil){
        [cell.content removeFromSuperview];
        cell.content=nil;
    }
    cell.image= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
    [cell.image setImage:[UIImage imageNamed:@"back.jpg"]];
    [cell addSubview:cell.image];
    //textField
    cell.content=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
//    [cell.content addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [cell.content setFont:[UIFont systemFontOfSize:180/self.count]];
    cell.content.textAlignment=NSTextAlignmentCenter;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:cell.content];
    [cell addSubview:cell.content];
    return cell;
}


//导航栏变透明
- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > 1)
            {
                textField.text = [toBeString substringToIndex:1];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > 0)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:0];
            if (rangeIndex.length == 0)
            {
                textField.text = [toBeString substringToIndex:0];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 0)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

//懒加载
-(UILabel *)lazytitlelabel{
    if(_titlelabel==nil){
        CGFloat width=self.view.frame.size.width;
        _titlelabel=[[YLVerticalAlignmentLabel alloc]initWithFrame:CGRectMake(0, 0, width,85 )];
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.colors = @[(__bridge id) UIColorFromHex(0x3366ff).CGColor,(__bridge id)UIColorFromHex(0x37c6fb).CGColor];
        //设置渐变的方向
        //(0,0)->(1,0)从左往右
        //(0,0)->(0,0)从上往下
        grad.startPoint = CGPointMake(0, 0);
        grad.endPoint = CGPointMake(1, 1);
        grad.cornerRadius=0;
        //设置渐变的起始位置 (从哪个点开始渐变到下一个颜色)
        // 设置不透明
        grad.frame=_titlelabel.bounds;
        [_titlelabel.layer addSublayer:grad];
        [_titlelabel setText:@"生   僻   字"];
        _titlelabel.textAlignment=NSTextAlignmentCenter;
        [_titlelabel setVerticalAlignment:VerticalAlignmentBottom];
        [_titlelabel setFont:[UIFont boldSystemFontOfSize:35]];
        [self.view addSubview:_titlelabel];
    }
    return _titlelabel;
}
-(UILabel *)lazytitlelabel1{
    //导航栏
    if(_titlelabel1==nil){
        _titlelabel1= [[UILabel alloc]init];
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
        
    }
    return _titlelabel1;
}


-(UILabel *)lazytextlabel1{
    if(_textlabel1==nil){
        CGFloat width=self.view.frame.size.width;
        _textlabel1= [[UILabel alloc]initWithFrame:CGRectMake(0, 185,width/3*2 , 15)];
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.colors = @[(__bridge id) UIColorFromHex(0x3366ff).CGColor,(__bridge id)UIColorFromHex(0x37c6fb).CGColor];
        //设置渐变的方向
        //(0,0)->(1,0)从左往右
        //(0,0)->(0,0)从上往下
        grad.startPoint = CGPointMake(0, 0);
        grad.endPoint = CGPointMake(1, 1);
        grad.cornerRadius=0;
        //设置渐变的起始位置 (从哪个点开始渐变到下一个颜色)
        // 设置不透明度
        grad.frame=_textlabel1.bounds;
        [_textlabel1.layer addSublayer:grad];
        
        [self.view addSubview:_textlabel1];
       
    }
    return _textlabel1;
}
-(UILabel *)lazytextlabel2{
    if(_textlabel2==nil){
        CGFloat width=self.view.frame.size.width;
        _textlabel2= [[UILabel alloc]initWithFrame:CGRectMake(width/3,335,width/3*2 ,15)];
        CAGradientLayer *grad = [CAGradientLayer layer];
        grad.colors = @[(__bridge id) UIColorFromHex(0x3366ff).CGColor,(__bridge id)UIColorFromHex(0x37c6fb).CGColor];
        //设置渐变的方向
        //(0,0)->(1,0)从左往右
        //(0,0)->(0,0)从上往下
        grad.startPoint = CGPointMake(0, 0);
        grad.endPoint = CGPointMake(1, 1);
        grad.cornerRadius=0;
        //设置渐变的起始位置 (从哪个点开始渐变到下一个颜色)
        // 设置不透明度
        grad.frame=_textlabel2.bounds;
        [_textlabel2.layer addSublayer:grad];
        [self.view addSubview:_textlabel2];
        
    }
    return _textlabel2;
}

-(UILabel *)lazytextlabel3{
    if(_textlabel3==nil){
        CGFloat width=self.view.frame.size.width;
        _textlabel3=[[UILabel alloc]initWithFrame:CGRectMake(30,(350+215)/2-80,width/3*2 ,50)];
        [_textlabel3 setText:@"请在下方输入要查询的组合"];
        UILabel *text4=[[UILabel alloc]initWithFrame:CGRectMake(width/3, (350+215)/2-80+50, width/3*2, 50)];
        [text4 setText:@"如“月”+“月”+“鸟”=“鹏”。"];
        text4.backgroundColor=[UIColor clearColor];
        [self.view addSubview:text4];
        _textlabel3.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_textlabel3];
    }
    return _textlabel3;
}
-(UILabel *)lazytextlabel4{
    if(_textlabel4==nil){
        CGFloat width=self.view.frame.size.width;
        _textlabel4=[[UILabel alloc]initWithFrame:CGRectMake(width/3,400,width/3*2-100 ,50)];
        [_textlabel4 setText:@"组合的字个数(3或4): "];
        _option1= [[dropDownLabel alloc]initWithFrame:CGRectMake(width-100,400+12.5,45 ,25)];
        _option2= [[dropDownLabel alloc]initWithFrame:CGRectMake(width-100,400+12.5,45 ,25)];
        [_option1 setText:@"3"];
        [_option2 setText:@"4"];
        _option1.textAlignment=NSTextAlignmentCenter;
        _option2.textAlignment=NSTextAlignmentCenter;
        //设置layer
        CALayer *layer=[_option1 layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:0];
        [layer setBorderWidth:1];
        [layer setBorderColor:[[UIColor blackColor] CGColor]];
        layer=[_option2 layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:0];
        [layer setBorderWidth:1];
        [layer setBorderColor:[[UIColor blackColor] CGColor]];
        _option1.backgroundColor=UIColorFromHex(0xF2F2F2);
        _option2.backgroundColor=UIColorFromHex(0xF2F2F2);
        self.count=3;
        [self.view addSubview:_option2];
        [self.view addSubview:_option1];
        
        UIImageView *image= [[UIImageView alloc]initWithFrame:CGRectMake(width-61-15+20,400+12.5,25 ,25)];
        image.image=[UIImage imageNamed:@"downArrow.png"];
        layer=[image layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:0];
        [layer setBorderWidth:1];
        [layer setBorderColor:[[UIColor blackColor] CGColor]];
        [self.view addSubview:image];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drop)];
        [image addGestureRecognizer:tap];
        image.userInteractionEnabled = YES;
        self.isDroped=NO;
        
        [self.view addSubview:image];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drop1)];
        [_option1 addGestureRecognizer:tap1];
        _option1.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(drop2)];
        [_option2 addGestureRecognizer:tap2];
        _option2.userInteractionEnabled = YES;
        
        _textlabel4.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_textlabel4];
    }
    return _textlabel4;
}
-(void)drop {
    if(self.isDroped==NO){
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
            CGFloat width=self.view.frame.size.width;
            self.option2.frame = CGRectMake(width-100,400+12.5,45 ,25);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
            // key frame 1
            CGFloat width=self.view.frame.size.width;
            self.option2.frame =CGRectMake(width-100,400+12.5+24,45 ,25);
        }];
    } completion:^(BOOL finished) {
    }];
        self.isDroped=YES;
    }else{
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
                CGFloat width=self.view.frame.size.width;
                self.option2.frame = CGRectMake(width-100,400+12.5+24,45 ,25);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
                // key frame 1
                CGFloat width=self.view.frame.size.width;
                self.option2.frame =CGRectMake(width-100,400+12.5,45 ,25);
            }];
        } completion:^(BOOL finished) {
        }];
        self.isDroped=NO;
    }
}
-(void)drop1{
    self.count=3;
    if(self.isDroped==YES){
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
                CGFloat width=self.view.frame.size.width;
                self.option2.frame = CGRectMake(width-100,400+12.5+24,45 ,25);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
                // key frame 1
                CGFloat width=self.view.frame.size.width;
                self.option2.frame =CGRectMake(width-100,400+12.5,45 ,25);
            }];
        } completion:^(BOOL finished) {
            if([self.option1.text isEqualToString:@"3"]){
                [self.option1 setText:@"3"];
                [self.option2 setText:@"4"];
                self.count=3;
                UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
                Layout.minimumLineSpacing=10;
                Layout.minimumInteritemSpacing=10;
                Layout.itemSize=CGSizeMake( 300/self.count, 300/self.count);
                self.collectionView.collectionViewLayout=Layout;
                [self.collectionView reloadData];
            }else{
                [self.option1 setText:@"4"];
                [self.option2 setText:@"3"];
                self.count=4;
                UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
                Layout.minimumLineSpacing=10;
                Layout.minimumInteritemSpacing=10;
                Layout.itemSize=CGSizeMake( 300/self.count, 300/self.count);
                self.collectionView.collectionViewLayout=Layout;
                [self.collectionView reloadData];
            }
        }];
        self.isDroped=NO;
        
    }
}
-(void)drop2{
    if(self.isDroped==YES){
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.6 animations: ^{
                CGFloat width=self.view.frame.size.width;
                self.option2.frame = CGRectMake(width-100,400+12.5+24,45 ,25);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations: ^{
                // key frame 1
                CGFloat width=self.view.frame.size.width;
                self.option2.frame =CGRectMake(width-100,400+12.5,45 ,25);
            }];
        } completion:^(BOOL finished) {
            if([self.option2.text isEqualToString:@"3"]){
                [self.option1 setText:@"3"];
                [self.option2 setText:@"4"];
                self.count=3;
                UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
                Layout.minimumLineSpacing=10;
                Layout.minimumInteritemSpacing=10;
                Layout.itemSize=CGSizeMake( 300/self.count, 300/self.count);
                self.collectionView.collectionViewLayout=Layout;
                [self.collectionView reloadData];
            }else{
                [self.option1 setText:@"4"];
                [self.option2 setText:@"3"];
                self.count=4;
                UICollectionViewFlowLayout *Layout=[[UICollectionViewFlowLayout alloc]init];
                Layout.minimumLineSpacing=10;
                Layout.minimumInteritemSpacing=10;
                Layout.itemSize=CGSizeMake( 300/self.count, 300/self.count);
                self.collectionView.collectionViewLayout=Layout;
                [self.collectionView reloadData];
            }
            
        }];
        self.isDroped=NO;
        ;
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}
-(void)log{
     self.p = [[MyLogViewController alloc]initWithTitle:@"历史记录" type:1];
    [self.navigationController pushViewController:self.p animated:NO];
    
    
    [self.navigationController.navigationBar setHidden:NO];
    
}


@end
