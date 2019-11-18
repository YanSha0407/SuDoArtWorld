//
//  VAFocusTableCell.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAFocusTableCell.h"
@interface VAFocusTableCell()
@property(nonatomic,retain)UILabel *courseName;
@property(nonatomic,retain)UIImageView *courseImage;
@property(nonatomic,retain)UILabel *courseSubName;
@property(nonatomic,retain)UILabel *courseCount;
@property(nonatomic,retain)UILabel *focusBtn;
@end
@implementation VAFocusTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.courseName];
        [self.contentView addSubview:self.courseImage];
        [self.contentView addSubview:self.courseSubName];
        [self.contentView addSubview:self.courseCount];
        [self.contentView addSubview:self.focusBtn];
        [self.courseImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(10);
            make.height.mas_equalTo(80);
            make.width.mas_equalTo(80 *16/9);
        }];
        [self.courseName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.courseImage);
            make.left.mas_equalTo(self.courseImage.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView).mas_offset(-10);
            make.height.mas_equalTo(40);
        }];
        [self.courseSubName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.courseName) ;
            make.top.mas_equalTo(self.courseName.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(60);
            make.top.mas_equalTo(self.courseSubName.mas_bottom);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        }];
        [self.courseCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.courseSubName);
            make.top.mas_equalTo(self.courseSubName.mas_bottom);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}
-(UILabel *)courseName{
    if (!_courseName) {
        _courseName = [[UILabel alloc]init];
        _courseName.text = @"主标题";
        _courseName.numberOfLines = 0;
        _courseName.textColor = VAMainTitleColor;
        _courseName.font = VAMainTitleFont;
    }
    return _courseName;
}

-(UILabel *)courseSubName{
    if (!_courseSubName) {
        _courseSubName = [[UILabel alloc]init];
        _courseSubName.text = @"副标题";
        _courseSubName.textAlignment = NSTextAlignmentLeft;
        _courseSubName.textColor = VASubTitleColor;
        _courseSubName.font = VASubTitleFont;
    }
    return _courseSubName;
}

-(UILabel *)courseCount{
    if (!_courseCount) {
        _courseCount = [[UILabel alloc]init];
        _courseCount.text = @"课程期数";
        _courseCount.textAlignment = NSTextAlignmentLeft;
        _courseCount.textColor = VASubTitleColor;
        _courseCount.font = VASubTitleFont;
    }
    return _courseCount;
}

-(UIImageView *)courseImage{
    if (!_courseImage) {
        _courseImage = [[UIImageView alloc]init];
        _courseImage.backgroundColor = VAGrayUnUseColor;
        _courseImage.contentMode = UIViewContentModeScaleAspectFill;
        KClipsCornerRadius(_courseImage, 5);
    }
    return _courseImage;
}

-(UILabel *)focusBtn{
    if (!_focusBtn) {
        _focusBtn = [[UILabel alloc]init];
        _focusBtn.textColor = VASubTitleColor;
        _focusBtn.font = VASubTitleFont;
        [_focusBtn setText:[NSString stringWithFormat:@"关注 %@",Kicon_del_heart]];
        UIFont *iconfont = [UIFont fontWithName:@"iconfont" size: 15];
        NSMutableDictionary * dic=[NSMutableDictionary dictionary];
        dic[NSFontAttributeName]=iconfont;
        dic[NSForegroundColorAttributeName]=VAMainAppColor;
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:_focusBtn.text];
        [AttributedStr addAttributes:dic
                               range:NSMakeRange(_focusBtn.text.length - 2 , 2)];
        _focusBtn.attributedText = AttributedStr;
    }
    return _focusBtn;
}
@end
