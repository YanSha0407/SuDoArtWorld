//
//  UIButton+Extension.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/18.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VACategoryLeftTabelView : UITableView
@property (nonatomic, copy  ) void(^CellSelectedBlock)(NSIndexPath *indexPath);
@property (nonatomic, assign) NSInteger selectedRow;
@end
