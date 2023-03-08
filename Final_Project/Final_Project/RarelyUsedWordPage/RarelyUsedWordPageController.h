//
//  RarelyUsedWordPageController.h
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/18.
//  Copyright © 2019年 mzq. All rights reserved.
//

#ifndef RarelyUsedWordPageController_h
#define RarelyUsedWordPageController_h
#import <UIKit/UIKit.h>
#import "worldbottom.h"
#import "../TransLogPage/LogController.h"
@interface RarelyUsedWordPageController : UIViewController 

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
@property(nonatomic,strong) NSDictionary * content;
@property(nonatomic,strong) UIImageView *loading;
@property(nonatomic,strong) MyLogViewController *p;
@property  Boolean isDroped;
@property  NSInteger count;
@property  NSArray *content2;
@property  NSInteger number;
@property NSString *query;
@property NSString *result;
-(void)drop;
@end


#endif /* RarelyUsedWordPageController_h */
