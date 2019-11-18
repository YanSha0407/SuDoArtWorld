//
//  YSImageScrollView.m
//  MeiShuQuan
//
//  Created by 007 on 2016/11/14.
//  Copyright © 2016年 YanSha. All rights reserved.
//

#import "YSImageScrollView.h"
@interface YSImageScrollView()<iCarouselDataSource,iCarouselDelegate>

@end

@implementation YSImageScrollView
{ // 定义完全私有的属性 : 添加成员变量,因为不需要懒加载,所以不需要是属性
    NSTimer *_timer;
}
- (instancetype)initWithFocusImgNumber:(NSInteger)number {
    if (self = [super init]) {
        self.bannerMutableArray = [NSMutableArray array];
        // 先关闭自己已存在定时器
        [_timer invalidate];
        // 当前没有头部滚动视图, 返回空对象nil
        if (!number) return nil;
        
        //头部视图origin无效,宽度无效,肯定是与table同宽
        if (number) {
//          if (IS_PAD) {
            self.frame = CGRectMake(0, -1,KSystemWidth, KSystemWidth *9 /16); // 660*210
//          }
//          else{
//            self.frame = CGRectMake(0, -1,KSystemWidth, KSystemWidth *9 /16); // 660*210
//          }
        }
        // 添加滚动栏
        _ic = [iCarousel new];
        [self addSubview:_ic];
        [_ic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        // 如果只有一张图,则不可以滚动
        _ic.scrollEnabled = number != 1;
        //    _ic.scrollSpeed = 1;
        // 让图片一张一张滚, 默认NO  滚一次到尾
        _ic.pagingEnabled = YES;
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = number;
        [_ic addSubview:_pageControl];
        _ic.delegate = self;
        _ic.dataSource = self;
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(-6);
            make.height.mas_equalTo(10);
        }];
        // 如果只有一张图,则不显示圆点
        _pageControl.hidesForSinglePage = YES;
        // 小圆点不与用户交互
        _pageControl.userInteractionEnabled = NO;
        // 小圆点颜色设置
        _pageControl.pageIndicatorTintColor = [UIColor lightTextColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        // 计时器产生,开启滚动
        if (number > 1) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
        }
    }
    return self;
}

-(void)action{
    [_ic scrollToItemAtIndex:_ic.currentItemIndex+1 animated:YES];
}

#pragma mark - iCarousel代理方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.bannerMutableArray.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    UIImageView *imgView = nil;
    CGRect frame = CGRectMake(0, -1,KSystemWidth, KSystemWidth *9 / 16); // 660*210
    if (!view) {
        view = [[UIView alloc] initWithFrame:frame]; //660*210
        imgView = [UIImageView new];
        [view addSubview:imgView];
        imgView.tag = 100;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        view.clipsToBounds = YES;
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    imgView = (UIImageView *)[view viewWithTag:100];
    if (self.bannerMutableArray.count) {
//        YSBannerModel *model=self.bannerMutableArray[index];
//        [imgView sd_setImageWithURL:[NSURL URLWithString:model.thumbs_image] placeholderImage:YSPlaceholderImage];
    }
    return view;
}

// @option
/** 允许循环滚动 */
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
    return value;
}

/**  监控滚到第几个 */
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    _pageControl.currentPage = carousel.currentItemIndex;
}
/**  点击第几个 */
-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if ([self.VADelegate respondsToSelector:@selector(clickTopBannerItemAction:)]) {
        [self.VADelegate clickTopBannerItemAction:index];
    }
}
@end
