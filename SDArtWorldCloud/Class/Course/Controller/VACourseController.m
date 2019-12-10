//
//  VACourseController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/7/11.
//  Copyright © 2019年 metis2017. All rights reserved.
//  课程主页

#import "VACourseController.h"
#import "VACourseCell.h"
#import "UIButton+Extension.h"
#import "YSImageScrollView.h"
#import "VALoginController.h"
#import "VACourseDetailController.h"
#define  kCOURSEVOLLECTIOCELL @"VACourseCell"
#define  HEADER_IDENTIFIER @"UICollectionReusableView"
#define VAImageScrollViewHight 120
#define VACategoryBtnViewHight 160
@interface VACourseController ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout,QMUISearchControllerDelegate>
@property (nonatomic,retain) UICollectionView *courseCollectionView;
@property (assign, nonatomic) CGFloat collectionViewCellWidth;
@property (nonatomic,strong) YSImageScrollView *sectionHeadView;
@property (nonatomic,strong) UIView *categoryBtnView;
@property (nonatomic,strong) NSMutableArray *bannerMutableArray;
@property (nonatomic,strong) NSMutableArray *categoryMutableArray;
@property (nonatomic,strong) QMUISearchController *searchController;
@end

@implementation VACourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.view addSubview:self.courseCollectionView];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(clickLogin)];
    self.navigationItem.titleView = self.searchController.searchBar;
}
-(void)clickLogin{
    VALoginController *vc = [[VALoginController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(UICollectionView *)courseCollectionView{
    if (!_courseCollectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        layout.minimumColumnSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        layout.columnCount = 2;
        self.collectionViewCellWidth = (KSystemWidth -layout.sectionInset.left-layout.sectionInset.right-(layout.columnCount-1)*layout.minimumColumnSpacing) / layout.columnCount;
        self.courseCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        self.courseCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.courseCollectionView.dataSource = self;
        self.courseCollectionView.delegate = self;
        self.courseCollectionView.showsVerticalScrollIndicator = NO;
        self.courseCollectionView.showsHorizontalScrollIndicator = NO;
        [self.courseCollectionView  registerClass:[VACourseCell class] forCellWithReuseIdentifier:kCOURSEVOLLECTIOCELL];
        [self.courseCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIER];
        self.courseCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self headerRefreshBegin];
        }];
        self.courseCollectionView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self footerRefreshBegin];
        }];
        if ([self.courseCollectionView.mj_header isRefreshing]) {
            [self.courseCollectionView.mj_header endRefreshing];
        }
//      [self.courseCollectionView.mj_header beginRefreshing];
        self.courseCollectionView.backgroundColor = VAMainBgColor;
    }
    return _courseCollectionView;
}
-(void)headerRefreshBegin{
    
}
-(void)footerRefreshBegin{
    
}
#pragma mark ----- 搜索框
-(QMUISearchController *)searchController{
    if (!_searchController) {
        _searchController = [[QMUISearchController alloc]initWithContentsViewController:self];
        _searchController.searchResultsDelegate = self;
    }
    return _searchController;
}
-(NSMutableArray *)bannerMutableArray{
    if (!_bannerMutableArray) {
        _bannerMutableArray = [NSMutableArray array];
    }
    return _bannerMutableArray;
}
-(NSMutableArray *)categoryMutableArray{
    if (!_categoryMutableArray) {
        _categoryMutableArray = [NSMutableArray array];
    }
    return _categoryMutableArray;
}
#pragma mark ----- 顶部banner
-(YSImageScrollView *)sectionHeadView{
    if (!_sectionHeadView) {
        YSImageScrollView *sectionHeadView = [[YSImageScrollView alloc]initWithFocusImgNumber:4];
        sectionHeadView.backgroundColor = VAWhiteColor;
        _sectionHeadView = sectionHeadView;
    }
    return _sectionHeadView;
}
#pragma mark ----- 顶部八个按钮
-(UIView *)categoryBtnView{
    if (!_categoryBtnView) {
        _categoryBtnView = [[UIView alloc]init];
        _categoryBtnView.frame = CGRectMake(0, self.sectionHeadView.bottom, KSystemWidth, VACategoryBtnViewHight);
        [self addVideoCategory];
    }
    return _categoryBtnView;
}
-(void)addVideoCategory{
    int count = 4;//一行四个icon
    CGFloat iconWidth = KSystemWidth/count;
    CGFloat iconHeight = VACategoryBtnViewHight/2;
    for (int i = 0; i < 8; i++ ) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn setImage:VAImage(@"huahua") forState:UIControlStateNormal];
        [btn setTitle:@"画画" forState:UIControlStateNormal];
        [btn setTitleColor:VAMainTitleColor forState:UIControlStateNormal];
        btn.titleLabel.font = VASubTitleFont;
        [self.categoryBtnView addSubview:btn];
        CGFloat x = 0;
        CGFloat y = (i/count)*iconHeight;
        if (i < 4) {
            x = i*iconWidth;
        }
        else{
            x = (i-4)*iconWidth;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(x);
            make.top.mas_equalTo(y);
            make.width.mas_equalTo(iconWidth);
            make.height.mas_equalTo(iconHeight);
        }];
        [btn setUpImageAndDownLableWithSpace:10];
        
    }
}
#pragma mark ----- UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VACourseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCOURSEVOLLECTIOCELL forIndexPath:indexPath];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    VACourseDetailController *vc = [[VACourseDetailController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionViewCellWidth, self.collectionViewCellWidth * 9/16 + 80);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
     if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
         if (indexPath.section == 0) {
           UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIER forIndexPath:indexPath];
             [reusableView addSubview:self.sectionHeadView];
             [reusableView addSubview:self.categoryBtnView];
           return reusableView;
         }
     }
    return nil;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return VACategoryBtnViewHight + VAImageScrollViewHight;
    }
    return 0;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsety = scrollView.contentOffset.y;
    if (contentOffsety<=170) {
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        self.navigationItem.titleView = self.searchController.searchBar;
        self.navigationItem.leftBarButtonItem = nil;
    }else{
        UILabel *la = [[UILabel alloc]init];
        la.text = @"课程";
        la.textColor = VAWhiteColor;
        la.font = [UIFont systemFontOfSize:18];
        self.navigationItem.titleView = la;
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_search"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLogin)];
    }
    self.navigationController.navigationBar.barTintColor = VAMainAppColor;
}

-(void)loadViewIfNeeded{
    [super loadViewIfNeeded];
}
@end
