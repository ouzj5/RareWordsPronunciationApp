//
//  NewLayout.m
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/27.
//  Copyright © 2019年 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewLayout.h"
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0  green:(((s & 0xFF00) >> 8))/255.0  blue:((s & 0xFF))/255.0  alpha:1.0]
@interface NewLayout()
@end

@implementation NewLayout
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //ti mu
    CGContextAddRect(context, CGRectMake(0, 0, rect.size.width, 90));
    
    //di 1 tiao gang
    CGContextAddRect(context, CGRectMake(0, 130, 280, 12));
    //di 2 tiao gang
    CGContextAddRect(context, CGRectMake(rect.size.width - 320, 310, 320, 12));
    //填充
    CGContextSetFillColorWithColor(context, UIColorFromHex(0x439bf2).CGColor);
    //绘制路径及填充模式
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGFloat xuxianArray[] = {10, 10};
    CGFloat dashArray[] = {5, 10};//表示先画1个点再画4个点（前者小后者大时，虚线点小且间隔大；前者大后者小时，虚线点大且间隔小）
    CGContextSetLineDash(context, 1, xuxianArray, 2);
    CGContextMoveToPoint(context, 15, 130 + 12 + 10);
    CGContextAddLineToPoint(context, rect.size.width - 10, 130 + 12+ 10);
    CGContextAddLineToPoint(context, rect.size.width - 10, 310 - 10);
    CGContextAddLineToPoint(context, 15, 310 - 10);
    CGContextAddLineToPoint(context, 15, 130 + 15);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);

    
    ////////////////////////////////
    CGContextSetLineWidth(context, 0);
    CGContextAddRect(context, CGRectMake(0, rect.size.height - 110, rect.size.width, 110));
    //填充
    CGContextSetFillColorWithColor(context, UIColorFromHex(0x439bf2).CGColor);
    //绘制路径及填充模式
    CGContextDrawPath(context, kCGPathFillStroke);
    //CGContextSetLineWidth(context, 2.0);
    
    CGContextAddArc(context, rect.size.width - 30,
                    rect.size.height - 95, 100/2, 0, 2 * M_PI, 0);
    CGContextAddRect(context, CGRectMake(rect.size.width - 100, rect.size.height - 125, 130 , 50));
    //填充
    CGContextSetFillColorWithColor(context, UIColorFromHex(0x439bf2).CGColor);
    //绘制路径及填充模式
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddArc(context, rect.size.width - 30 - 67,
                    rect.size.height - 110 - 31, 31, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    NSString* t1 = @"生";//别
    NSString* t2 = @"僻";
    NSString* t3 = @"字";
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize: 50], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    // 3.渲染文字内容 NSFontAttributeName
    [t1 drawAtPoint:CGPointMake(rect.size.width/3-100, 20)withAttributes:attrs];
    [t2 drawAtPoint:CGPointMake(rect.size.width/3*2 - 100, 20)withAttributes:attrs];
    [t3 drawAtPoint:CGPointMake(rect.size.width - 100, 20)withAttributes:attrs];


}

@end
