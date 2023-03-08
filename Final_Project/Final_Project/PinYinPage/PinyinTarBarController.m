//
//  TarBarController.m
//  Final_Project
//
//  Created by BlackWhite on 2019/12/17.
//  Copyright © 2019 mzq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PinyinTarBarController.h"

@interface PinyinTarBarController ()
-(void)initWithTitle:(NSString*) str;
@end

@implementation PinyinTarBarController
-(void)initWithTitle:(NSString*) str{
    self.str1=str;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title=self.str1;
    
}

@end
