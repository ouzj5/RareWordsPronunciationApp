//
//  EqualSpaceFlowLayoutEvolve.h
//  Final_Project
//
//  Created by 许泰琪 on 2019/12/20.
//  Copyright © 2019年 mzq. All rights reserved.
//

#ifndef EqualSpaceFlowLayoutEvolve_h
#define EqualSpaceFlowLayoutEvolve_h
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface EqualSpaceFlowLayoutEvolve : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

-(instancetype)initWthType : (AlignType)cellType;

@end



#endif /* EqualSpaceFlowLayoutEvolve_h */
