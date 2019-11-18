//
//  YKPageView.m
//  YKPageView
//
//  Created by Mark on 15/4/27.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "YKPageView.h"
#import "YKMenuView.h"

static CGFloat const YKTitleSizeSelected     = 18.0f;
static CGFloat const YKTitleSizeNormol       = 15.0f;
static CGFloat const YKMenuViewDefaultHeight = 30.0f;
static CGFloat const YKMenuItemDefaultWidth  = 60.0f;

@interface YKPageView () <UIScrollViewDelegate, YKMenuViewDelegate>{
    BOOL _animate;
    BOOL _setted;
}
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableSet *reusePool;
@property (nonatomic, assign) CGFloat menuViewHeight;
@property (nonatomic, strong) NSMutableDictionary *displayCells;
@property (nonatomic, strong) NSMutableArray *cellFrames;
@property (nonatomic, weak) YKMenuView *menuView;
@end

@implementation YKPageView
#pragma mark - Lazy load
- (NSMutableDictionary *)displayCells {
    if (_displayCells == nil) {
        _displayCells = [[NSMutableDictionary alloc] init];
    }
    return _displayCells;
}

- (NSMutableArray *)cellFrames {
    if (_cellFrames == nil) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableSet *)reusePool {
    if (_reusePool == nil) {
        _reusePool = [[NSMutableSet alloc] init];
    }
    return _reusePool;
}

- (CGFloat)menuViewHeight {
    if (!_menuViewHeight) {
        if ([self.delegate respondsToSelector:@selector(pageView:heightForMenuView:)]) {
            _menuViewHeight = [self.delegate pageView:self heightForMenuView:self.menuView];
        } else {
            _menuViewHeight = YKMenuViewDefaultHeight;
        }
    }
    return _menuViewHeight;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self reloadData];
}

// 添加菜单栏
- (void)addMenuView {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.menuViewHeight;
    NSArray *items = [self.dataSource menuItemsForMenuViewInPageView:self];
    CGRect frame = CGRectMake(0, 0, width, height);
    UIColor *color,*norColor,*selColor;
    CGFloat norSize,selSize;
    if ([self.delegate respondsToSelector:@selector(backgroundColorOfMenuViewInPageView:)]) {
        color = [self.delegate backgroundColorOfMenuViewInPageView:self];
    }
    if ([self.delegate respondsToSelector:@selector(titleColorOfMenuItemInPageView:withState:)]) {
        norColor = [self.delegate titleColorOfMenuItemInPageView:self withState:YKMenuItemTitleColorStateNormal];
        selColor = [self.delegate titleColorOfMenuItemInPageView:self withState:YKMenuItemTitleColorStateSelected];
    }
    if ([self.delegate respondsToSelector:@selector(titleSizeOfMenuItemInPageView:withState:)]) {
        norSize = [self.delegate titleSizeOfMenuItemInPageView:self withState:YKMenuItemTitleSizeStateNormal];
        selSize = [self.delegate titleSizeOfMenuItemInPageView:self withState:YKMenuItemTitleSizeStateSelected];
    } else {
        norSize = YKTitleSizeNormol;
        selSize = YKTitleSizeSelected;
    }
    YKMenuView *menuView = [[YKMenuView alloc] initWithFrame:frame buttonItems:items backgroundColor:color norSize:norSize selSize:selSize norColor:norColor selColor:selColor];
    menuView.delegate = self;
    self.menuView.lineColor = self.progressColor;
    switch (self.menuViewStyle) {
        case YKMenuViewStyleLine:
            menuView.style = YKMenuViewStyleLine;
            break;
        case YKMenuViewStyleFoold:
            menuView.style = YKMenuViewStyleFoold;
            break;
        case YKMenuViewStyleFooldHollow:
            menuView.style = YKMenuViewStyleFooldHollow;
            break;
        default:
            break;
    }
    [self addSubview:menuView];
    self.menuView = menuView;
}
// 添加主滚动视图
-(void)addScrollView1{
  CGFloat x = 0;
  CGFloat y = self.menuViewHeight;
  CGFloat width = self.frame.size.width;
  CGFloat height = self.frame.size.height - self.menuViewHeight;
  UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, width, height)];
  scrollView.showsHorizontalScrollIndicator = NO;
  scrollView.showsVerticalScrollIndicator = NO;
  scrollView.pagingEnabled = YES;
  scrollView.delegate = self;
  NSUInteger numOfCells = [[self.dataSource menuItemsForMenuViewInPageView:self] count];
  for (int i = 0; i < numOfCells; i++) {
    CGFloat x = i * width;
    CGFloat y = 0;
    CGRect frame = CGRectMake(x, y, width, height);
    if (i == 0) {
      YKPageCell *cell = [self.dataSource pageView:self cellForIndex:i];
      cell.frame = frame;
      [scrollView addSubview:cell];
      
      [self.displayCells setObject:cell forKey:@(i)];
    }
    [self.cellFrames addObject:[NSValue valueWithCGRect:frame]];
  }
  CGFloat contentX = self.frame.size.width*numOfCells;
  CGFloat contentY = height;
  scrollView.contentSize = CGSizeMake(contentX, contentY);
  scrollView.bounces = NO;
  [self addSubview:scrollView];
  self.scrollView = scrollView;
}
- (BOOL)isInScreen:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat ScreenWidth = self.scrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) > contentOffsetX && x-contentOffsetX < ScreenWidth) {
        return YES;
    } else {
        return NO;
    }
}

// 排列items
- (void)layoutItems {
    for (int i = 0; i < self.cellFrames.count; i++) {
        YKPageCell *cell = self.displayCells[@(i)];
        CGRect frame = [self.cellFrames[i] CGRectValue];
        if ([self isInScreen:frame]) {
            if (cell == nil) {
                // cell不存在时，问数据源要cell
                cell = [self.dataSource pageView:self cellForIndex:i];
                cell.frame = frame;
                [self.scrollView addSubview:cell];
                // 放到展示中的数组中，以便取用
                [self.displayCells setObject:cell forKey:@(i)];
            }
        } else {
            // cell存在且不在屏幕中
            if (cell) {
                // 移除屏幕上显示的cell
                [self.displayCells removeObjectForKey:@(i)];
                [cell removeFromSuperview];
                // 放入缓存池
                [self.reusePool addObject:cell];
            }
        }
    }
}

// 清空所有数组，字典，并移除所有子控件
- (void)clearAllData {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayCells removeAllObjects];
    [self.reusePool removeAllObjects];
    [self.cellFrames removeAllObjects];
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    if (self.scrollView) {
        [self.scrollView removeFromSuperview];
    }
}

#pragma mark - Public Methods
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (self.menuView) {
        [self.menuView selectItemAtIndex:selectIndex];
    }
}

- (void)setToAnimate:(BOOL)toAnimate {
    _toAnimate = toAnimate;
    _setted = YES;
}

- (void)reloadData {
    [self clearAllData];
    [self addMenuView];
    [self addScrollView1];
    if (self.selectIndex != 0) {
        [self.menuView selectItemAtIndex:self.selectIndex];
    }
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    __block YKPageCell *reuseCell;
    [self.reusePool enumerateObjectsUsingBlock:^(YKPageCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reuseCell = cell;
            *stop = YES;
        }
    }];
    if (reuseCell) {
        [self.reusePool removeObject:reuseCell];
    }
    return reuseCell;
}

#pragma mark - MenuView delegate
- (void)menuView:(YKMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    _animate = NO;
    CGPoint targetP = CGPointMake(self.scrollView.frame.size.width*index, 0);
    [self.scrollView setContentOffset:targetP animated:(_setted ? self.toAnimate : YES)];
}

- (CGFloat)menuView:(YKMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(pageView:widthForMenuItemAtIndex:)]) {
        return [self.delegate pageView:self widthForMenuItemAtIndex:index];
    } else {
        return YKMenuItemDefaultWidth;
    }
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self layoutItems];
    if (_animate) {
        CGFloat width = scrollView.frame.size.width;
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        
        CGFloat rate = contentOffsetX / width;
        [self.menuView slideMenuAtProgress:rate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _animate = YES;
}

@end
