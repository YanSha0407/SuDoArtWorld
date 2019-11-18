//
//  VABaseViewController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/7/11.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VABaseViewController.h"

@interface VABaseViewController ()

@end

@implementation VABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VAMainBgColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO; // UINavigationController 遮挡View //
}

@end
