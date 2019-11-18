//
//  VANavViewController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/7/11.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VANavViewController.h"

@interface VANavViewController ()

@end

@implementation VANavViewController
+ (void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = VAMainAppColor;
    bar.tintColor = VAWhiteColor;
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : VAWhiteColor,NSFontAttributeName:[UIFont systemFontOfSize:16]}];
}

@end
