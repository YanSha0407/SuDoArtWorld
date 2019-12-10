//
//  VACategoryController.m
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/20.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACategoryController.h"
#import "VACategoryLeftTabelView.h"
#import "VACategoryRightCollectionView.h"

@interface VACategoryController ()<UIScrollViewDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) VACategoryLeftTabelView *leftView;
@property (nonatomic, strong) VACategoryRightCollectionView *rightView;
@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) BOOL didEndDecelerating;
@end

@implementation VACategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightTextColor];
    [self setupSubViews];
}
/**
 *思路1
 *使用CollectionView,每个cell添加一个collectionView
 */
#pragma mark -------UI设置-------
- (void)setupSubViews {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    VACategoryLeftTabelView *leftView = [[VACategoryLeftTabelView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.leftView = leftView;
    [self.view addSubview:leftView];
    __weak typeof(self) weakSelf = self;
    [leftView setCellSelectedBlock:^(NSIndexPath *indexPath) {
        [weakSelf.rightView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
    }];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(KSystemWidth - 100, KSystemHeight - NavigateHeight);
    VACategoryRightCollectionView *rightView = [[VACategoryRightCollectionView alloc] initWithFrame:CGRectMake(101, 0, KSystemWidth - 101, KSystemHeight - NavigateHeight) collectionViewLayout:flowLayout];
    self.rightView = rightView;
    rightView.delegate = self;
    rightView.pagingEnabled = YES;
    [self.view addSubview:rightView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.didEndDecelerating = YES;
    // 调用方法A，传scrollView.contentOffset
    [self scrollViewWithScrollView:scrollView];
    NSLog(@"停止滑动");
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f", offsetY);
    CGFloat height = self.rightView.height;
    NSLog(@"高度%f", height);
    NSInteger index = offsetY/height;
    self.leftView.selectedRow = index;
}
- (void)scrollViewWithScrollView:(UIScrollView *)scrollView {
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < _lastContentOffset) {
//        NSLog(@"上");
        
    }else {
//        NSLog(@"下");
    }
}


@end
