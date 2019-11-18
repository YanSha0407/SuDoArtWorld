//
//  VAPhotoCollectionViewCell.m
//  TwoTableLinkage
//
//  Created by stkcctv on 16/9/18.
//  Copyright © 2016年 stkcctv. All rights reserved.
//

#import "VAPhotoCollectionViewCell.h"

@implementation VAPhotoCollectionViewCell

//懒加载创建数据
-(UIImageView *)photoV{
    if (_photoV == nil) {
        self.photoV = [[UIImageView alloc]initWithFrame:self.bounds];
        self.photoV.contentMode = UIViewContentModeScaleAspectFill;
        self.photoV.clipsToBounds = YES;
    }
    return _photoV;
}

//创建自定义cell时调用该方法
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoV];
    }
    return self;
}


@end
