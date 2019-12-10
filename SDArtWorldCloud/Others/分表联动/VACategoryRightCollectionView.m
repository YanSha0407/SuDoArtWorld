//
//  UIButton+Extension.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/18.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACategoryRightCollectionView.h"
#import "VACategoryRightCollectionCell.h"

@interface VACategoryRightCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation VACategoryRightCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[VACategoryRightCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VACategoryRightCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.sectionTitle = [NSString stringWithFormat:@"%ld", indexPath.row];
    if (indexPath.row == 0) {
        cell.count = 5;
    }else if (indexPath.row == 1) {
        cell.count = 20;
    }else if (indexPath.row == 2) {
        cell.count = 20;
    }else if (indexPath.row == 3) {
        cell.count = 7;
    }else if (indexPath.row == 4) {
        cell.count = 12;
    }else {
        cell.count = 10;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
