//
//  UIButton+Extension.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/18.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACategoryLeftTableCell.h"

@interface VACategoryLeftTableCell ()


@end

@implementation VACategoryLeftTableCell
+ (instancetype)cellWithTableView:(UITableView *)tabelView {
    static NSString *ID = @"VACategoryLeftTableCell";
    VACategoryLeftTableCell *cell = [tabelView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 100, 45)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    [self.contentView addSubview:titleLabel];
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.height)];
    leftLine.backgroundColor = VAMainAppColor;
    leftLine.hidden = YES;
    self.leftLine = leftLine;
    [self addSubview:leftLine];
}




@end
