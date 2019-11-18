//
//  VAFocusController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAFocusController.h"
#import "VAFocusTableCell.h"
@interface VAFocusController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *focusTableView;
@property(nonatomic,retain)NSMutableArray *courseMutableArray;
@end

@implementation VAFocusController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.focusTableView];
}
-(UITableView *)focusTableView{
    if (!_focusTableView) {
        _focusTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSystemWidth, KSystemHeight - 83) style:UITableViewStyleGrouped];
        _focusTableView.dataSource = self;
        _focusTableView.delegate  = self;
        _focusTableView.backgroundColor = VAMainBgColor;
        _focusTableView.showsVerticalScrollIndicator = NO;
        _focusTableView.showsHorizontalScrollIndicator = NO;
        _focusTableView.tableFooterView = [[UIView alloc]init];
        _focusTableView.separatorColor = VASeparatorColor;
    }
    return _focusTableView;
}
-(NSMutableArray *)courseMutableArray{
    if (!_courseMutableArray) {
        _courseMutableArray = [NSMutableArray array];
    }
    return _courseMutableArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VAFocusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VAFocusTableCell"];
    if (!cell) {
        cell = [[VAFocusTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VAFocusTableCell"];
        cell.backgroundColor = TableViewBackgroundColor;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, KSystemWidth - 20, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:bgView.frame];
    label.textColor = VASubTitleColor;
    UIFont *iconfont = [UIFont fontWithName:@"iconfont" size: 15];
    [label setText:[NSString stringWithFormat:@"%@ 正在学习",Kicon_del_heart]];
    label.font = iconfont;
    [bgView addSubview:label];
    return bgView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
@end
