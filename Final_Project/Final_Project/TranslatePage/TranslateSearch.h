//
//  TranslateSearch.h
//  Final_Project
//
//  Created by mzq on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#ifndef TranslateSearch_h
#define TranslateSearch_h

#import <UIKit/UIKit.h>
#import "Record.h"
#import "LogController.h"
#import "DrawTranslate.h"

@interface TranslateSearch : UIViewController
<UITableViewDelegate, UITableViewDataSource>
//@property(nonatomic,strong)UILabel *titleText;

@property(nonatomic, strong) DrawTranslate *draw;
@property(nonatomic, copy)NSArray *dataArray;
@property(nonatomic, copy)NSArray *languageArray;
@property(nonatomic, copy)NSArray *flagsArray;

@property(nonatomic, strong)UIButton *button1;
@property(nonatomic, strong)UIButton *button2;
@property(nonatomic, strong)UITableView *tableView1;
@property(nonatomic, strong)UITableView *tableView2;

//@property(nonatomic, strong)UILabel *midLabel;
//@property(nonatomic, strong)UIButton *submitButton;
@property(nonatomic, strong)UITextField *textField;

@property(nonatomic)NSInteger button_num1;
@property(nonatomic)NSInteger button_num2;

@property(nonatomic, strong) UITableView *tabelView_data1;
@property(nonatomic, strong) UITableView *tabelView_data2;
@property(nonatomic, strong) NSString *user_input_str;

@property(nonatomic, strong) __block NSDictionary *getDic;

@property(nonatomic, strong) NSString *q;
@property(nonatomic, strong) NSString *from;
@property(nonatomic, strong) NSString *to;
@property(nonatomic, strong) NSString *appid;
@property(nonatomic, strong) NSString *apppwd;
@property(nonatomic, strong) NSString *salt;
@property(nonatomic, strong) NSString *sign;

@property(nonatomic, strong) __block Record *record;
@property(nonatomic, strong) UITextView *textView;

@end


#endif /* TranslateSearch_h */

