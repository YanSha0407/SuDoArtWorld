//
//  VALoginController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/13.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VALoginController.h"

@interface VALoginController ()<QMUITextFieldDelegate>
@property (nonatomic,retain)UIView *loginBgView; // 登录背景
@property (nonatomic,retain)QMUITextField *phoneNumTextFiled;// 手机号
@property (nonatomic,retain)QMUITextField *codeTextFiled;// 验证码
@property (nonatomic,retain)UIButton *getCodeBtn;// 获取验证码
@property (nonatomic,retain)UIButton *loginBtn; //登录btn
@property (nonatomic,retain)UIButton *changePwdBtn; //切换密码登录
@property (nonatomic,retain)UIButton *fogetPwdBtn; // 忘记密码
@end

@implementation VALoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.view addSubview:self.loginBgView];
    [self.loginBgView addSubview:self.phoneNumTextFiled];
    [self.loginBgView addSubview:self.codeTextFiled];
    [self.loginBgView addSubview:self.getCodeBtn];
    [self.loginBgView addSubview:self.loginBtn];
    [self.loginBgView addSubview:self.changePwdBtn];
    [self.loginBgView addSubview:self.fogetPwdBtn];
    [self.loginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(KSystemHeight/2);
    }];
    [self.phoneNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.loginBgView);
        make.top.mas_equalTo(self.loginBgView.mas_top);
        make.width.mas_equalTo(self.loginBgView);
        make.height.mas_equalTo(45);
    }];
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumTextFiled.mas_bottom).inset(20);
        make.width.mas_equalTo((KSystemWidth-30*2)*2/3);
        make.left.height.mas_equalTo(self.phoneNumTextFiled);
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.codeTextFiled);
        make.width.mas_equalTo((KSystemWidth-30*2)/3);
        make.left.mas_equalTo(self.codeTextFiled.mas_right);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.codeTextFiled.mas_bottom).mas_offset(20);
         make.left.height.width.mas_equalTo(self.phoneNumTextFiled);
    }];
    [self.changePwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.loginBtn);
         make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(5);
         make.width.mas_equalTo(100);
         make.height.mas_equalTo(30);
    }];
    [self.fogetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.loginBtn);
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}
-(UIView *)loginBgView{
    if (!_loginBgView) {
        _loginBgView = [[UIView alloc]init];
        _loginBgView.backgroundColor = VAMainBgColor;
    }
    return _loginBgView;
}
-(QMUITextField *)phoneNumTextFiled{
    if (!_phoneNumTextFiled) {
        _phoneNumTextFiled = [[QMUITextField alloc]init];
        _phoneNumTextFiled.backgroundColor = VAWhiteColor;
        _phoneNumTextFiled.layer.borderColor = VASeparatorColor.CGColor;;
        _phoneNumTextFiled.layer.borderWidth = PixelOne;
        _phoneNumTextFiled.placeholder = @"请输入手机号";
        _phoneNumTextFiled.font = VAMainTitleFont;
        _phoneNumTextFiled.delegate = self;
        _phoneNumTextFiled.typingAttributes = @{NSForegroundColorAttributeName: UIColorRed};
    }
    return _phoneNumTextFiled;
}
-(QMUITextField *)codeTextFiled{
    if (!_codeTextFiled) {
        _codeTextFiled = [[QMUITextField alloc]init];
        _codeTextFiled.backgroundColor = VAWhiteColor;
        _codeTextFiled.layer.borderColor = VASeparatorColor.CGColor;;
        _codeTextFiled.layer.borderWidth = PixelOne;
        _codeTextFiled.placeholder = @"请输入验证码";
        _codeTextFiled.font = VAMainTitleFont;
        _codeTextFiled.delegate = self;
        _codeTextFiled.typingAttributes = @{NSForegroundColorAttributeName: UIColorRed};
    }
    return _codeTextFiled;
}
-(UIButton *)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn = [[UIButton alloc]init];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:VAWhiteColor forState:UIControlStateNormal];
        [_getCodeBtn setBackgroundColor:VAMainAppColor];
        _getCodeBtn.titleLabel.font = VASubTitleFont;
    }
    return _getCodeBtn;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:VAWhiteColor forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:VAMainAppColor];
        _loginBtn.titleLabel.font = VAMainTitleFont;
        KClipsCornerRadius(_loginBtn, 20);
    }
    return _loginBtn;
}
-(UIButton *)changePwdBtn{
    if (!_changePwdBtn) {
        _changePwdBtn = [[UIButton alloc]init];
        _changePwdBtn.titleLabel.font = VASubTitleFont;
        [_changePwdBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_changePwdBtn setTitleColor:VASubTitleColor forState:UIControlStateNormal];
    }
    return _changePwdBtn;
}
-(UIButton *)fogetPwdBtn{
    if (!_fogetPwdBtn) {
        _fogetPwdBtn = [[UIButton alloc]init];
        _fogetPwdBtn.titleLabel.font = VASubTitleFont;
        [_fogetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_fogetPwdBtn setTitleColor:VASubTitleColor forState:UIControlStateNormal];
    }
    return _fogetPwdBtn;
}
#pragma mark - <QMUITextFieldDelegate>

- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    [QMUITips showWithText:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textField.maximumTextLength)] inView:self.view hideAfterDelay:2.0];
}
@end
