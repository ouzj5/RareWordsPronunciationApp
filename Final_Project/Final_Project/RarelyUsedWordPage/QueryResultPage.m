//
//  RarelyUsedWordPageController.m
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/18.
//  Copyright © 2019年 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryResultPage.h"
#import "worldbottom.h"
#import "LMJDropdownMenu.h"
#import "InputCell.h"
#import "OutputCell.h"
#import "../MainPage.h"
#import "EqualSpaceFlowLayoutEvolve.h"
#import "NewLayout.h"
#import "../TransLogPage/LogController.h"
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0  green:(((s & 0xFF00) >> 8))/255.0  blue:((s & 0xFF))/255.0  alpha:1.0]

@interface  QueryResultPage()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation QueryResultPage
-(instancetype)initWithNumber:(NSInteger)number dictionary:(NSArray*)dic queryArray:(NSArray*)queryArray history:(MyLogViewController *)p{
    
    if(self){
        _queryArray=queryArray;
        _count=number;
        if(_count>=9)_count=9;
        _dictionary=dic;
        _p=p;
    }
    self=[super init];
    return  self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=UIColorFromHex(0xF2F2F2);
    
//    [self lazytitlelabel];
    
//    [self lazytextlabel1];
//    [self lazytextlabel2];
   
    NewLayout *draw = [[NewLayout alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:draw];
    [self lazytextlabel3];
    //[self lazytitlelabel1];
    EqualSpaceFlowLayoutEvolve *Layout=[[EqualSpaceFlowLayoutEvolve alloc]initWthType:AlignWithCenter];
    Layout.minimumLineSpacing=10;
    Layout.minimumInteritemSpacing=80;

    NSLog(@"%ld",_count);
    NSInteger size=_count;
    if(size>=5)size=5;
    Layout.itemSize=CGSizeMake( 270/size, 250/size+20);
    CGFloat width=self.view.frame.size.width;
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(25,400,width-50,300) collectionViewLayout:Layout];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.backgroundColor=[UIColor clearColor];
    self.collectionView.scrollEnabled=NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[OutputCell class] forCellWithReuseIdentifier:@"cell"];
   
    
    
    
    UIButton *query= [[UIButton alloc]initWithFrame:CGRectMake(width/3-45, 700, 90, 40)];
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.colors = @[(__bridge id) UIColorFromHex(0x3366ff).CGColor,(__bridge id)UIColorFromHex(0x37c6fb).CGColor];
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
    [query setTitle:@"继续查询" forState:UIControlStateNormal];
    [query setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:query];
    UIButton *query1= [[UIButton alloc]initWithFrame:CGRectMake((width)*2/3-45, 700, 90, 40)];
    CAGradientLayer *grad1 = [CAGradientLayer layer];
    grad1.colors = @[(__bridge id) UIColorFromHex(0x3366ff).CGColor,(__bridge id)UIColorFromHex(0x37c6fb).CGColor];
    //设置渐变的方向
    //(0,0)->(1,0)从左往右
    //(0,0)->(0,0)从上往下
    grad1.startPoint = CGPointMake(0, 0);
    grad1.endPoint = CGPointMake(1, 1);
    grad1.cornerRadius=10;
    //设置渐变的起始位置 (从哪个点开始渐变到下一个颜色)
    // 设置不透明
    grad1.frame=query1.bounds;
    [query1.layer addSublayer:grad1];
    [query1 setTitle:@"返回首页" forState:UIControlStateNormal];
    [query1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:query1];
    [query addTarget:self action:@selector(returnQuery) forControlEvents:UIControlEventTouchDown];
    [query1 addTarget:self action:@selector(returnHome) forControlEvents:UIControlEventTouchDown];
}
-(void)returnQuery{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)returnHome{
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

//Collection Cell
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(_count>=9)_count=9;
    return _count;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OutputCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //background
    if(cell.image!=nil){
        [cell.image removeFromSuperview];
        cell.image=nil;
    }
    cell.image= [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, cell.bounds.size.width, cell.bounds.size.height-20)];
    [cell.image setImage:[UIImage imageNamed:@"back.jpg"]];
    
    cell.content=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, cell.bounds.size.width, cell.bounds.size.height-20)];
    cell.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, 20)];
    for(int i=0;i<self.count;i++){
        NSDictionary* content1= [self.dictionary objectAtIndex:i];
        if(indexPath.row==i){
            [cell.content setText:[content1 objectForKey:@"word"]];
            [cell.title setText:[content1 objectForKey:@"pinyin"]];
            cell.title.textAlignment=AlignWithCenter;
            cell.content.textAlignment=AlignWithCenter;
            NSInteger size=self.count;
            if(size>=5)size=5;
            [cell.content setFont:[UIFont systemFontOfSize:180/size]];
            [cell addSubview:cell.image];
            [cell addSubview:cell.content];
            [cell addSubview:cell.title];
        }
    }
    CGFloat collectionHeight = _collectionView.bounds.size.height;
        cell.alpha = 1.0f;
        cell.transform = CGAffineTransformMakeTranslation(0, collectionHeight);
    
        [UIView animateWithDuration:0.7f delay:0.5*indexPath.row usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            cell.transform =  CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    return cell;
}
-(void)animateCollection{
    NSArray *cells = _collectionView.visibleCells;
    CGFloat collectionHeight = _collectionView.bounds.size.height;
    for (UICollectionViewCell *cell in cells.objectEnumerator) {
        cell.alpha = 1.0f;
        cell.transform = CGAffineTransformMakeTranslation(0, collectionHeight);
        NSUInteger index = [cells indexOfObject:cell];
        [UIView animateWithDuration:0.7f delay:0.5*index usingSpringWithDamping:0.8 initialSpringVelocity:0 options:0 animations:^{
            cell.transform =  CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }
}

//导航栏变透明
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
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
        grad.colors = @[(__bridge id)UIColorFromHex(0x37c6fb).CGColor,(__bridge id) UIColorFromHex(0x3366ff).CGColor];
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
        _textlabel3=[[UILabel alloc]initWithFrame:CGRectMake(15,(350+215)/2-80,width-30 ,130)];
        _textlabel3.backgroundColor=[UIColor clearColor];
        [self.view addSubview:_textlabel3];
        if(_queryArray.count==3){
            UILabel *a1=[[UILabel alloc]initWithFrame:CGRectMake(30,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            UILabel *a2=[[UILabel alloc]initWithFrame:CGRectMake(30+15+(width-30-40)/3,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            UILabel *a3=[[UILabel alloc]initWithFrame:CGRectMake(30+30+(width-30-40)/3*2,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            UIImage *image=[UIImage imageNamed:@"back.jpg"];
            UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(30,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            [imageView1 setImage:image];
            UIImageView *imageView2= [[UIImageView alloc]initWithFrame:CGRectMake(30+15+(width-30-40)/3,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            [imageView2 setImage:image];
            UIImageView *imageView3= [[UIImageView alloc]initWithFrame:CGRectMake(30+30+(width-30-40)/3*2,((350+215)/2-80+15),(width-30-40)/3-15 ,100)];
            [imageView3 setImage:image];
            [self.view addSubview:imageView1];
            [self.view addSubview:imageView2];
            [self.view addSubview:imageView3];
            a1.backgroundColor= [UIColor clearColor];
            a2.backgroundColor= [UIColor clearColor];
            a3.backgroundColor= [UIColor clearColor];
            
            [a1 setText:[self.queryArray objectAtIndex:0]];
            [a2 setText:[self.queryArray objectAtIndex:1]];
            [a3 setText:[self.queryArray objectAtIndex:2]];
            UIFont *font = [UIFont systemFontOfSize:80];
            a1.textAlignment=NSTextAlignmentCenter;
            a2.textAlignment=NSTextAlignmentCenter;
            a3.textAlignment=NSTextAlignmentCenter;
            [a1 setFont:font];
            [a2 setFont:font];
            [a3 setFont:font];
            [self.view addSubview:a1];
            [self.view addSubview:a2];
            [self.view addSubview:a3];
        }else{
            UILabel *a1=[[UILabel alloc]initWithFrame:CGRectMake(30,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            UILabel *a2=[[UILabel alloc]initWithFrame:CGRectMake(30+10+(width-30-40)/4,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            UILabel *a3=[[UILabel alloc]initWithFrame:CGRectMake(30+20+(width-30-40)/4*2,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            UILabel *a4=[[UILabel alloc]initWithFrame:CGRectMake(30+30+(width-30-40)/4*3,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            UIImage *image=[UIImage imageNamed:@"back.jpg"];
            UIImageView *imageView1= [[UIImageView alloc]initWithFrame:CGRectMake(30,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            [imageView1 setImage:image];
            UIImageView *imageView2= [[UIImageView alloc]initWithFrame:CGRectMake(30+10+(width-30-40)/4,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            [imageView2 setImage:image];
            UIImageView *imageView3= [[UIImageView alloc]initWithFrame:CGRectMake(30+20+(width-30-40)/4*2,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            [imageView3 setImage:image];
            UIImageView *imageView4= [[UIImageView alloc]initWithFrame:CGRectMake(30+30+(width-30-40)/4*3,((350+215)/2-80+25),(width-30-40)/4-15 ,75)];
            [imageView4 setImage:image];
            [self.view addSubview:imageView1];
            [self.view addSubview:imageView2];
            [self.view addSubview:imageView3];
            [self.view addSubview:imageView4];
            a1.backgroundColor= [UIColor clearColor];
            a2.backgroundColor= [UIColor clearColor];
            a3.backgroundColor= [UIColor clearColor];
            a4.backgroundColor= [UIColor clearColor];
            [a1 setText:[self.queryArray objectAtIndex:0]];
            [a2 setText:[self.queryArray objectAtIndex:1]];
            [a3 setText:[self.queryArray objectAtIndex:2]];
            [a4 setText:[self.queryArray objectAtIndex:3]];
            UIFont *font = [UIFont systemFontOfSize:60];
            a1.textAlignment=NSTextAlignmentCenter;
            a2.textAlignment=NSTextAlignmentCenter;
            a3.textAlignment=NSTextAlignmentCenter;
            a4.textAlignment=NSTextAlignmentCenter;
            [a1 setFont:font];
            [a2 setFont:font];
            [a3 setFont:font];
            [a4 setFont:font];
            [self.view addSubview:a1];
            [self.view addSubview:a2];
            [self.view addSubview:a3];
            [self.view addSubview:a4];
        }
       
    }
    return _textlabel3;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"back");
}
-(void)log{
    MyLogViewController *p = [[MyLogViewController alloc]initWithTitle:@"历史记录" type:1];
    [self.navigationController pushViewController:p animated:NO];
    [self.navigationController.navigationBar setHidden:NO];
}


@end

