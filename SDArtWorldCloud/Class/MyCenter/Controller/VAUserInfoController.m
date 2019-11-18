//
//  VAUserInfoController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAUserInfoController.h"
#import "VAUserInfoCell.h"
#import "VAUserInfoModel.h"
#import "LZCleanCaches.h"
#import "LQPickerView.h"
#import "LQCityPicker.h"
#import "VAUserFeedBackController.h"
@interface VAUserInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UITableView *userInfoTableView;
@property (nonatomic, strong) NSMutableArray *cityDataSource;
@end

@implementation VAUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];// 加载城市数据
    self.view.backgroundColor = VAMainBgGrayColor;
    [self.view addSubview:self.userInfoTableView];
}
- (NSMutableArray *)cityDataSource {
    if (_cityDataSource == nil) {
        _cityDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _cityDataSource;
}
-(UITableView *)userInfoTableView{
    if (!_userInfoTableView) {
        _userInfoTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, KSystemWidth - 20, KSystemHeight) style:UITableViewStylePlain];
        _userInfoTableView.dataSource = self;
        _userInfoTableView.delegate  = self;
        _userInfoTableView.showsVerticalScrollIndicator = NO;
        _userInfoTableView.showsHorizontalScrollIndicator = NO;
        _userInfoTableView.tableFooterView = [[UIView alloc]init];
        _userInfoTableView.separatorColor = VASeparatorColor;
        KClipsCornerRadius(_userInfoTableView, 10);
    }
    return _userInfoTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userInfoArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VAUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VAUserInfoCell"];
    if (!cell) {
        cell = [[VAUserInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VAUserInfoCell"];
        cell.backgroundColor = TableViewBackgroundColor;
    }
    if (self.userInfoArray.count) {
        cell.infoModel = self.userInfoArray[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.userInfoArray.count) {
        VAUserInfoModel *infoModel = self.userInfoArray[indexPath.row];
        if ([infoModel.cellName isEqualToString:@"意见反馈"]) {
            VAUserFeedBackController *vc = [[VAUserFeedBackController alloc]init];
            vc.title = @"意见反馈";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([infoModel.cellName isEqualToString:@"清除缓存"]){
            [[LZCleanCaches sharedInstance]cleanCache:^{
                infoModel.cellSubName = @"0.0M";
                [self.userInfoTableView reloadData];
            }];
        }
        else if ([infoModel.cellName isEqualToString:@"性别"]){
            [self showRadioSelectionDialogViewController:infoModel];
        }
        else if ([infoModel.cellName isEqualToString:@"昵称"]){
            [self showReturnKeyDialogViewController:infoModel];
        }
        else if ([infoModel.cellName isEqualToString:@"地区"]){
            [self chooseCityAddress:infoModel];
        }
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
         return 75;
    }
    else{
        return 56;
    }
}
#pragma mark - /** 加载数据源 */
- (void)loadData {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSArray *provinces = [dic allKeys];
    
    for (NSString *tmp in provinces) {
        
        // 创建第一级数据
        LQPickerItem *item1 = [[LQPickerItem alloc]init];
        item1.name = tmp;
        
        NSArray *arr = [dic objectForKey:tmp];
        NSDictionary *cityDic = [arr firstObject];
        
        NSArray *keys = cityDic.allKeys;
        // 配置第二级数据
        [item1 loadData:keys.count config:^(LQPickerItem *item, NSInteger index) {
            
            item.name = keys[index];
            NSArray *area = [cityDic objectForKey:item.name];
            // 配置第三极数据
            [item loadData:area.count config:^(LQPickerItem *item, NSInteger index) {
                item.name = area[index];
            }];
        }];
        
        [self.cityDataSource addObject:item1];
    }
}
#pragma mark ---选择地区
-(void)chooseCityAddress:(VAUserInfoModel *)infoModel{
    __weak typeof(self)ws = self;
    [LQCityPicker showInView:self.view datas:self.cityDataSource didSelectWithBlock:^(NSArray *objs, NSString *dsc) {
        infoModel.cellSubName = dsc;
        [ws.userInfoTableView reloadData];
    } cancelBlock:^{
       
    }];
}
#pragma mark ---选择性别
- (void)showRadioSelectionDialogViewController:(VAUserInfoModel *)infoModel{
    QMUIOrderedDictionary *citys = [[QMUIOrderedDictionary alloc] initWithKeysAndObjects:
                                    @"男",@"男",
                                    @"女",@"女",
                                    nil];
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    dialogViewController.title = @"请选择性别";
    dialogViewController.items = citys.allKeys;
    dialogViewController.rowHeight = 56;
    dialogViewController.titleLabelTextColor = VAMainTitleColor;
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        QMUIDialogSelectionViewController *d = (QMUIDialogSelectionViewController *)aDialogViewController;
        if (d.selectedItemIndex == QMUIDialogSelectionViewControllerSelectedItemIndexNone) {
            [QMUITips showError:@"请至少选一个" inView:d.qmui_modalPresentationViewController.view hideAfterDelay:1.2];
            return;
        }
        NSString *city = d.items[d.selectedItemIndex];
        NSString *resultString = (NSString *)[citys objectForKey:city];
        [aDialogViewController hideWithAnimated:YES completion:^(BOOL finished) {
            infoModel.cellSubName = resultString;
            [self.userInfoTableView reloadData];
        }];
    }];
    [dialogViewController show];
}

#pragma mark ---修改昵称
- (void)showReturnKeyDialogViewController:(VAUserInfoModel *)infoModel{
    QMUIDialogTextFieldViewController *dialogViewController = [[QMUIDialogTextFieldViewController alloc] init];
    dialogViewController.title = @"请输入昵称";
    [dialogViewController addTextFieldWithTitle:nil configurationHandler:^(QMUILabel *titleLabel, QMUITextField *textField, CALayer *separatorLayer) {
        textField.placeholder = @"请输入昵称...";
        textField.maximumTextLength = 10;
    }];
    dialogViewController.shouldManageTextFieldsReturnEventAutomatically = YES;// 让键盘的 Return 键也能触发确定按钮的事件。这个属性默认就是 YES，这里为写出来只是为了演示
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *dialogViewController) {
        [QMUITips showSucceed:@"提交成功" inView:self.view hideAfterDelay:1.2];
        [dialogViewController hide];
    }];
    [dialogViewController show];
}
@end
