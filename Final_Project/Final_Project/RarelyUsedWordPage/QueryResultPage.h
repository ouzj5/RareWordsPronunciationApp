//
//  ResultPage.h
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/19.
//  Copyright © 2019年 mzq. All rights reserved.
//

#ifndef ResultPage_h
#define ResultPage_h
#import <UIKit/UIkit.h>
#import "worldbottom.h"
#import "../TransLogPage/LogController.h"
@interface QueryResultPage :UIViewController
@property(nonatomic,strong) YLVerticalAlignmentLabel *titlelabel;
@property(nonatomic,strong) UILabel *titlelabel1;
@property(nonatomic,strong) UILabel *textlabel1;
@property(nonatomic,strong) UILabel *textlabel2;
@property(nonatomic,strong) UILabel *textlabel3;
@property(nonatomic,strong) UILabel *textlabel4;
@property(nonatomic,strong) UILabel *option1;
@property(nonatomic,strong) UILabel *option2;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UILabel *resultFalse;
@property(nonatomic,strong) MyLogViewController *p;
@property  Boolean isDroped;
@property  NSInteger count;
@property NSArray *dictionary;
@property NSArray *queryArray;
-(instancetype)initWithNumber:(NSInteger)number dictionary:(NSArray*)dic queryArray:(NSArray*)queryArrayn history:(MyLogViewController*)p;
@end

#endif /* ResultPage_h */
