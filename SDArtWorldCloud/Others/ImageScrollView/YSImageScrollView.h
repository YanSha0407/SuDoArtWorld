//
//  YSImageScrollView.h
//  MeiShuQuan
//
//  Created by 007 on 2016/11/14.
//  Copyright © 2016年 YanSha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>

@protocol ClickTopBannerItemAction <NSObject>

-(void)clickTopBannerItemAction:(NSInteger)index;

@end

@interface YSImageScrollView : UIView
/**
 *  通过传入焦点图数量以及焦点图的图片路径,初始化一个View
 */
- (instancetype)initWithFocusImgNumber:(NSInteger)number;
@property (nonatomic,strong) iCarousel *ic;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) id <ClickTopBannerItemAction> VADelegate;
@property (nonatomic,strong) NSMutableArray *bannerMutableArray;
@end
