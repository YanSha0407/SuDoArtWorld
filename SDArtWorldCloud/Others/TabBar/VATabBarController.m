//
//  VATabBarController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/7/11.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VATabBarController.h"
#import "VAMyCenterController.h"
#import "VACourseController.h"
#import "VANavViewController.h"
#import "VABaseTabBar.h"
@interface VATabBarController ()

@end

@implementation VATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONEX_SAFEAREA > 0) {
        VABaseTabBar *baseTabBar = [[VABaseTabBar alloc] init];
        [self setValue:baseTabBar forKey:@"tabBar"];
    }
    self.tabBar.tintColor = VAMainAppColor;
    self.tabBar.backgroundColor = VAWhiteColor;
    [self setupAllChildViewControllers];
}

-(void)setupAllChildViewControllers
{
    NSArray *titles = @[@"课程", @"我的"];
    NSArray *iPhone_imageNames = @[@"ic_iPhone_topLine_unselected", @"ic_iPad_me_unselected"];
    NSArray *iPhone_Sel_imageNames = @[@"ic_iPhone_topLine_selected", @"ic_iPad_me_selected"];
    VACourseController *courseController = [[VACourseController alloc] init];
    [self setupChildViewController:courseController title:titles[0] imageName:iPhone_imageNames[0] selectedImageName:iPhone_Sel_imageNames[0]];
    VAMyCenterController *myCenterController = [[VAMyCenterController alloc] init];
    [self setupChildViewController:myCenterController title:titles[1] imageName:iPhone_imageNames[1] selectedImageName:iPhone_Sel_imageNames[1]];
}
/**
 * 初始化子控制器
 */
- (void)setupChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置文字
    vc.title = title;
    vc.tabBarItem.title = title;
    // 设置普通状态下图片
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = normalImage;
    // 设置选中状态下图片
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImage;
    
//    if ([title isEqualToString:@"我的"]) {
//        [self addChildViewController:vc];
//    }
//    else{
        // 包装一个导航控制器
        VANavViewController *nav = [[VANavViewController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
//    }
}
@end
