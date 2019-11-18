//
//  VAUserInfoCell.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAUserInfoCell.h"
@interface VAUserInfoCell()
@property(nonatomic,retain)UILabel *cellName;
@property(nonatomic,retain)UIImageView *cellImage;
@property(nonatomic,retain)UILabel *cellSubName;
@property(nonatomic,retain)UIButton *cellArrow;
@end

@implementation VAUserInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.cellName];
        [self.contentView addSubview:self.cellArrow];
        [self.contentView addSubview:self.cellSubName];
        [self.contentView addSubview:self.cellImage];
        [self.cellName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(20);
            make.right.mas_equalTo(self.mas_centerX);
            make.top.bottom.mas_equalTo(self);
        }];
        [self.cellArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-10);
            make.centerY.mas_equalTo(self.cellName.centerY);
            make.width.mas_equalTo(13);
            make.height.mas_equalTo(26);
        }];
        [self.cellSubName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cellArrow).mas_offset(-20);
            make.left.mas_equalTo(self.mas_centerX);
            make.top.bottom.mas_equalTo(self);
        }];
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cellArrow).mas_offset(-20);
            make.top.mas_equalTo(self).mas_offset(10);
            make.width.height.mas_equalTo(55);
        }];
    }
    return self;
}

-(UILabel *)cellName{
    if (!_cellName) {
        _cellName = [[UILabel alloc]init];
        _cellName.text = @"头像";
        _cellName.textColor = VAMainTitleColor;
        _cellName.font = VAMainTitleFont;
    }
    return _cellName;
}

-(UILabel *)cellSubName{
    if (!_cellSubName) {
        _cellSubName = [[UILabel alloc]init];
        _cellSubName.text = @"耿耿于怀";
        _cellSubName.textAlignment = NSTextAlignmentRight;
        _cellSubName.textColor = VASubTitleColor;
        _cellSubName.font = VASubTitleFont;
    }
    return _cellSubName;
}
-(UIImageView *)cellImage{
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        KClipsCornerRadius(_cellImage, 55/2);
        _cellImage.backgroundColor = VAGrayUnUseColor;
        _cellImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _cellImage;
}
-(UIButton *)cellArrow{
    if (!_cellArrow) {
        _cellArrow = [[UIButton alloc]init];
        [_cellArrow setImage:[UIImage imageNamed:@"ic_arrow"] forState:UIControlStateNormal];
    }
    return _cellArrow;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setInfoModel:(VAUserInfoModel *)infoModel{
    _infoModel = infoModel;
    self.cellName.text = self.infoModel.cellName;
    [self.cellImage setImageWithURL:VAURL(self.infoModel.cellSubName) usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.cellSubName.text = self.infoModel.cellSubName;
    if ([self.infoModel.cellType isEqualToString:@"image"]) {
        self.cellSubName.hidden = YES;
        self.cellImage.hidden = NO;
    }
    else{
        self.cellSubName.hidden = NO;
        self.cellImage.hidden = YES;
    }
    
}
@end
