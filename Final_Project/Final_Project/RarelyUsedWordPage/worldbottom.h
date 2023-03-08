//
//  worldbottom.h
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/18.
//  Copyright © 2019年 mzq. All rights reserved.
//

#ifndef worldbottom_h
#define worldbottom_h

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, VerticalAlignment)
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
};
@interface YLVerticalAlignmentLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlignment;

@end

#endif /* worldbottom_h */
