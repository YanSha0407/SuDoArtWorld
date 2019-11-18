//
//  VACourseCell.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/6.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VACourseCell.h"
@interface VACourseCell()

@property(nonatomic,strong)UIImageView *courseImageView; // 课程缩略图

@property(nonatomic,strong)UILabel *courseTitle; // 课程标题

@property(nonatomic,strong)UILabel *coursePrice; // 课程价格

@property(nonatomic,strong)UILabel *courseCount; // 课程统计

@end

@implementation VACourseCell

-(instancetype)initWithFrame:(CGRect)frame{
       if (self = [super initWithFrame:frame]) {
           [self addSubview:self.courseImageView];
           [self addSubview:self.courseTitle];
           [self addSubview:self.coursePrice];
           [self addSubview:self.courseCount];
           [self.courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.top.right.mas_equalTo(0);
               make.height.mas_equalTo(self.width *9/16);
           }];
           [self.courseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_equalTo(self.courseImageView.mas_bottom);
               make.left.right.mas_equalTo(self.courseImageView);
               make.height.mas_equalTo(60);
           }];
           [self.coursePrice mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.courseImageView);
               make.top.mas_equalTo(self.courseTitle.mas_bottom);
               make.width.mas_equalTo(60);
               make.height.mas_equalTo(20);
           }];
           [self.courseCount mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(self.courseImageView);
               make.top.mas_equalTo(self.coursePrice);
               make.left.mas_equalTo(self.coursePrice);
               make.height.mas_equalTo(self.coursePrice);
           }];
       }
    return self;
}

-(UIImageView *)courseImageView{
    if (!_courseImageView) {
        _courseImageView = [[UIImageView alloc]init];
        KClipsCornerRadius(_courseImageView, 3);
        _courseImageView.backgroundColor = VAGrayUnUseColor;
    }
    return _courseImageView;
}
-(UILabel *)courseTitle{
    if (!_courseTitle) {
        _courseTitle = [[UILabel alloc]init];
        _courseTitle.numberOfLines = 0;
        _courseTitle.text = @"标题";
        _courseTitle.font = VAMainTitleFont;
        _courseTitle.textColor = VAMainTitleColor;
    }
    return _courseTitle;
}
-(UILabel *)coursePrice{
    if (!_coursePrice) {
        _coursePrice = [[UILabel alloc]init];
        _coursePrice.text = @"价格";
        _coursePrice.textAlignment = NSTextAlignmentLeft;
        _coursePrice.font = VAMainTitleFont;
        _coursePrice.textColor = VAMainTitleColor;
    }
    return _coursePrice;
}
-(UILabel *)courseCount{
    if (!_courseCount) {
        _courseCount = [[UILabel alloc]init];
        _courseCount.text = @"观看数";
        _courseCount.textAlignment = NSTextAlignmentRight;
        _courseCount.font = VAMainTitleFont;
        _courseCount.textColor = VAMainTitleColor;
    }
    return _courseCount;
}
@end
