//
//  MyTabBarController.m
//  hw3
//
//  Created by 区梓俊 on 2019/10/6.
//  Copyright © 2019 区梓俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogController.h"
#import "AppDelegate.h"
#import "Record.h"
/*
 学习表格页面控制器
 */
@interface MyLogViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property NSInteger sectionNum;
@property NSInteger rowNum;
@property NSMutableArray *open;
@property NSMutableArray *record;
@property UIButton *btn;
@property (nonatomic, strong) UILabel *tl;
@property NSString *str;
@property Record *loader;
@property NSInteger type;
@end

@implementation MyLogViewController
- (id)initWithTitle:(NSString *) title type:(NSInteger) type{
    self = [super init];
    if (self) {
        _str = title;
        _type = type;
        _loader = [[Record alloc] initWithType:type];
        [self loadRecord];
    }
    return self;
}
- (void)loadRecord {
    _record = [_loader getRecord];
    _sectionNum = [_loader getNum] / 2;
    _open = [[NSMutableArray alloc] init];
    for (int i = 0; i < _sectionNum; i ++ ) {
        NSMutableArray *tem = [[NSMutableArray alloc] init];
        for (int j = 0; j < 2; j ++ ) {
            [tem addObject:[NSNumber numberWithInteger:1]];
        }
        [_open addObject:tem];
    }
    NSLog(@"row num: %ld", _rowNum);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     tableview 的创建以及委托
     */
    NSInteger x = self.view.bounds.origin.x;
    NSInteger width = self.view.bounds.size.width;
    NSInteger height = self.view.bounds.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, 140, width, height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0;
    _tl = [[UILabel alloc] initWithFrame:CGRectMake(x, 90, width, 50)];
    _tl.backgroundColor = _tableView.backgroundColor;
    _tl.text = _str;
    _tl.font = [UIFont boldSystemFontOfSize:24.0f];
    _tl.textAlignment = NSTextAlignmentCenter;
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_btn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
    _btn.frame = CGRectMake(0, 90, width / 4, 50);
    [_btn setTitle:@"删除记录" forState:UIControlStateNormal];
    
    [self.view addSubview:_tl];
    [self.view addSubview:_btn];
    [self.view addSubview:_tableView];
}

-(void) del:(UIButton *)sender {
    NSString * message = @"确认要删除吗";
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示信息" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.loader delRecord];
        self.loader = [[Record alloc] initWithType: self.type];
        [self loadRecord];
        [self.tableView reloadData];
        NSLog(@"OK Action");
    }];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel Action");
    }];
    [alertController addAction:confirmButton];
    [alertController addAction:cancelButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    _loader = [[Record alloc] initWithType: _type];
    [self loadRecord];
    [_tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionNum;
}
//设置section header
-(UITableViewCell *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (cell == nil) {
        //防止重复创建
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    }
    NSString *str = [[NSString alloc] initWithFormat:(@"header...")];
    cell.textLabel.text = str;
    return nil;
}
//设置每个cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    NSLog(@"%ld   %ld", indexPath.row, _record.count);
    NSString *str = [[NSString alloc] initWithFormat:(@"%@"), _record[indexPath.row + indexPath.section * 2]];
    cell.textLabel.text = str;
    NSNumber * num = _open[indexPath.section][indexPath.row];
    cell.textLabel.numberOfLines = [num integerValue];
    [cell sizeToFit];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSNumber * num = _open[indexPath.section][indexPath.row];
    NSLog(@"%ld", indexPath.row + indexPath.section * 2);
    _open[indexPath.section][indexPath.row] = [num integerValue] == 0 ? [NSNumber numberWithInteger:1] : [NSNumber numberWithInteger:0];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

