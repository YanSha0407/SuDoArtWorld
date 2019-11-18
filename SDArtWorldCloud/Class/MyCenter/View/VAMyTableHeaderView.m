//
//  VAMyTableHeaderView.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAMyTableHeaderView.h"
@interface VAMyTableHeaderView()
@property(nonatomic,retain)UIView *headerBgView;
@property(nonatomic,retain)UIView *userBgView;
@property(nonatomic,retain)UIImageView *userHeder;
@property(nonatomic,retain)UILabel *userName;
@property(nonatomic,retain)UIButton *arrowBtn;
@end
@implementation VAMyTableHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerBgView];
        [self addSubview:self.userBgView];
        [self.userBgView addSubview:self.userHeder];
        [self.userBgView addSubview:self.userName];
        [self.userBgView addSubview:self.arrowBtn];
        [self.headerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self);
            make.height.mas_equalTo(self.mas_height).mas_offset(-20);
        }];
        [self.userBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(10);
            make.right.mas_equalTo(self).mas_offset(-10);
            make.bottom.mas_equalTo(self);
            make.height.mas_equalTo(75);
        }];
        [self.userHeder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.userBgView).mas_offset(10);
            make.height.width.mas_equalTo(55);
        }];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(self.userHeder);
            make.left.mas_equalTo(self.userHeder.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.userBgView.mas_right).mas_offset(-50);
        }];
        [self.arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.userBgView.centerY);
            make.right.mas_equalTo(self.userBgView.mas_right).mas_offset(-10);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(26);
        }];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserHeaderView)];
        [self.userBgView addGestureRecognizer:tapGes];
    }
    return self;
}

-(UIView *)headerBgView{
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc]init];
        _headerBgView.backgroundColor = VAMainAppColor;
    }
    return _headerBgView;
}
-(UIView *)userBgView{
    if (!_userBgView) {
        _userBgView = [[UIView alloc]init];
        _userBgView.backgroundColor = VAMainBgColor;
        KClipsCornerRadius(_userBgView, 10);
        _userBgView.layer.borderColor = [VASeparatorColor CGColor];
        _userBgView.layer.borderWidth = PixelOne;
    }
    return _userBgView;
}
-(UIImageView *)userHeder{
    if (!_userHeder) {
        _userHeder = [[UIImageView alloc]init];
        KClipsCornerRadius(_userHeder, 55/2);
        _userHeder.backgroundColor = VAGrayUnUseColor;
    }
    return _userHeder;
}
-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.text = @"耿耿于怀";
        _userName.textColor = VAMainTitleColor;
        _userName.font = VAMainTitleFont;
    }
    return _userName;
}
-(UIButton *)arrowBtn{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc]init];
        [_arrowBtn setImage:[UIImage imageNamed:@"ic_arrow"] forState:UIControlStateNormal];
    }
    return _arrowBtn;
}
-(void)clickUserHeaderView{
    if ([self.VADelegate respondsToSelector:(@selector(clickUserHeaderView))]) {
        [self.VADelegate clickUserHeaderView];
    }
}
@end
