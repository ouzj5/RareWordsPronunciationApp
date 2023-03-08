//
//  DrawTranslate.m
//  Final_Project
//
//  Created by mzq on 2019/12/27.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawTranslate.h"
@interface DrawTranslate()
@end

@implementation DrawTranslate
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //ti mu
//    CGContextAddRect(context, CGRectMake(0, 0, rect.size.width, 90));
//
//    //di 1 tiao gang
//    CGContextAddRect(context, CGRectMake(0, 130, 280, 12));
//    //di 2 tiao gang
//    CGContextAddRect(context, CGRectMake(rect.size.width - 320, 310, 320, 12));
//    //填充
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.18 green:0.55 blue:0.36 alpha:1].CGColor);
//    //绘制路径及填充模式
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    //xu xian kuang
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGFloat xuxianArray[] = {10, 10};
//    CGFloat dashArray[] = {5, 10};//表示先画1个点再画4个点（前者小后者大时，虚线点小且间隔大；前者大后者小时，虚线点大且间隔小）
//    CGContextSetLineDash(context, 1, xuxianArray, 2);
//    CGContextMoveToPoint(context, 15, 130 + 12 + 10);
//    CGContextAddLineToPoint(context, rect.size.width - 10, 130 + 12+ 10);
//    CGContextAddLineToPoint(context, rect.size.width - 10, 310 - 10);
//    CGContextAddLineToPoint(context, 15, 310 - 10);
//    CGContextAddLineToPoint(context, 15, 130 + 15);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    /////// han zi ge
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    //CGFloat dashArray[] = {5, 10};//表示先画1个点再画4个点（前者小后者大时，虚线点小且间隔大；前者大后者小时，虚线点大且间隔小）
//    //CGContextSetLineDash(context, 1, dashArray, 2);
//    //int x1[i] = 60, y1[i] = 400, h1[i] = 120, w1[i] = 120;
//    int y2 = 450;
//    int x1[4] = {60, rect.size.width - 60 - 120, 60, rect.size.width - 60 - 120};
//    int y1[4] = {385, 385, 580, 580};
//    int h1[4] = {120, 120, 120, 120};
//    int w1[4] = {120, 120, 120, 120};
//    //xu xian
//    for (int i = 0; i < 4; i ++) {
//        CGFloat gezi[] = {5, 7};
//        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//        CGContextSetLineDash(context, 1, gezi, 2);
//        CGContextMoveToPoint(context, x1[i], y1[i]);
//        CGContextAddLineToPoint(context, x1[i] + w1[i], y1[i] + h1[i]);
//        CGContextStrokePath(context);
//        //
//        CGContextMoveToPoint(context, x1[i] + w1[i], y1[i]);
//        CGContextAddLineToPoint(context, x1[i], y1[i] + h1[i]);
//        CGContextStrokePath(context);
//        //
//        CGContextMoveToPoint(context, x1[i] + w1[i] / 2, y1[i]);
//        CGContextAddLineToPoint(context, x1[i] + w1[i] / 2, y1[i] + h1[i]);
//        CGContextStrokePath(context);
//        //
//        CGContextMoveToPoint(context, x1[i], y1[i] + h1[i] / 2);
//        CGContextAddLineToPoint(context, x1[i] + w1[i], y1[i] + h1[i] / 2);
//        CGContextStrokePath(context);
//        ////////////
//
//        CGFloat solid[] = {1, 0};//表示先画1个点再画4个点（前者小后者大时，虚线点小且间隔大；前者大后者小时，虚线点大且间隔小）
//        CGContextSetLineDash(context, 1, solid, 2);
//        CGContextMoveToPoint(context, x1[i], y1[i]);
//        CGContextAddLineToPoint(context, x1[i] + w1[i], y1[i]);
//        CGContextAddLineToPoint(context, x1[i] + w1[i], y1[i] + h1[i]);
//        CGContextAddLineToPoint(context, x1[i], y1[i] + h1[i]);
//        CGContextAddLineToPoint(context, x1[i], y1[i]);
//        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//        CGContextDrawPath(context, kCGPathFillStroke);
//    }
    
    ////////////////////////////////
    CGContextSetLineWidth(context, 0);
    CGContextAddRect(context, CGRectMake(0, rect.size.height - 110, rect.size.width, 110));
    //填充
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:216/255.0 green:65/255.0 blue:77/255.0 alpha:1].CGColor);
    //绘制路径及填充模式
    CGContextDrawPath(context, kCGPathFillStroke);
    //CGContextSetLineWidth(context, 2.0);
    
    CGContextAddArc(context, rect.size.width - 30,
                    rect.size.height - 95, 100/2, 0, 2 * M_PI, 0);
    CGContextAddRect(context, CGRectMake(rect.size.width - 100, rect.size.height - 125, 130 , 50));
    //填充
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:216/255.0 green:65/255.0 blue:77/255.0 alpha:1].CGColor);
    //绘制路径及填充模式
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddArc(context, rect.size.width - 30 - 67,
                    rect.size.height - 110 - 31, 31, 0, 2 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    ///hui zhi wen zi
//    NSString* t1 = @"识";//别
//    NSString* t2 = @"音";
//    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize: 50], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
//    // 3.渲染文字内容 NSFontAttributeName
//    [t1 drawAtPoint:CGPointMake(100, 20)withAttributes:attrs];
//    [t2 drawAtPoint:CGPointMake(rect.size.width - 100 - 50, 20)withAttributes:attrs];
//
//    NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize: 17], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
//    t1 = @"s h í";
//    t2 = @"y ī n";
//    [t1 drawAtPoint:CGPointMake(100 + 52, 17)withAttributes:attrs2];
//    [t2 drawAtPoint:CGPointMake(rect.size.width - 100 - 50 + 52, 17)withAttributes:attrs2];
    
}

@end
