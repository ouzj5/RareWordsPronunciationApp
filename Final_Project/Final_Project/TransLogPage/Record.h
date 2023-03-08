//
//  Record.h
//  final
//
//  Created by 区梓俊 on 2019/12/20.
//  Copyright © 2019 区梓俊. All rights reserved.
//

/*
 创建记录类，翻译页面创建一个用于添加记录
 */
#ifndef Record_h
#define Record_h
#import <UIKit/UIKit.h>
@interface Record : NSObject
@property NSInteger num;
@property NSInteger recordType;        //0, 1, 2


/*
使用以下两个函数，以及两个自己设置prefix（记录前的文字）。
*/
@property NSString *input_prefix;
@property NSString *output_prefix;
-(id)initWithType:(NSInteger)type;      //初始化，type为记录类型，数字为页面索引(0, 1, 2)
-(void)addRecord:(NSString *)str outcome:(NSString *)output;   //添加翻译，str为翻译的内容, output为结果

/*
 ..
 ..
 ..
 ..
 */
-(NSInteger)getNum;     //获取缓存中记录数目
-(NSMutableArray *)getRecord;       //获取缓存中所有的记录
-(void)delRecord;                   //删除所有的记录
@end

#endif /* Record_h */
