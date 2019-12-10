//
//  UIButton+Extension.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/18.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VACategoryLeftTableCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tabelView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *leftLine;
@end
