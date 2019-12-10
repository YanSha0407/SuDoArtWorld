//
//  UIButton+Extension.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/18.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VACategoryLeftTabelView.h"
#import "VACategoryLeftTableCell.h"

@interface VACategoryLeftTabelView ()<UITableViewDelegate, UITableViewDataSource>


@end

static NSString *leftCell = @"leftCell";

@implementation VACategoryLeftTabelView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight = 50;
        self.selectedRow = 0;
        [self registerClass:VACategoryLeftTableCell.class forCellReuseIdentifier:leftCell];
    }
    return self;
}

#pragma mark -------UITabelViewdataSource-------
- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VACategoryLeftTableCell *cell = [VACategoryLeftTableCell cellWithTableView:tableView];
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    tableView.tableFooterView = [UIView new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.selectedRow == indexPath.row) {
        cell.backgroundColor = VAMainAppColor;
        cell.leftLine.hidden = NO;
    }else {
        cell.backgroundColor = VAMainBgColor;
        cell.leftLine.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    [tableView reloadData];
    if (self.CellSelectedBlock) {
        self.CellSelectedBlock(indexPath);
    }
}
- (void)setSelectedRow:(NSInteger)selectedRow {
    _selectedRow = selectedRow;
    [self reloadData];
}


@end
