//
//  VAUserFeedBackController.m
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import "VAUserFeedBackController.h"
#import "VAPlaceholderTextView.h"
#import "VAPhotoCollectionViewCell.h"
#import "SystemInfo.h"
#import "VAPredicateMethod.h"

@interface VAUserFeedBackController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) VAPlaceholderTextView * textView;

@property (nonatomic, strong) UIButton * sendButton;

@property (nonatomic, strong) UIView * aView;

@property (nonatomic, strong)UICollectionView *collectionV;
//上传图片的个数
@property (nonatomic, strong)NSMutableArray *photoArrayM;
//上传图片的button
@property (nonatomic, strong)UIButton *photoBtn;
//回收键盘
@property (nonatomic, strong)UITextField *textField;

//字数的限制
@property (nonatomic, strong)UILabel *wordCountLabel;

@property (nonatomic, strong)NSString *imageStr;


@end

@implementation VAUserFeedBackController

//懒加载数组
- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VAMainBgGrayColor;
    self.aView = [[UIView alloc]init];
    _aView.backgroundColor = VAMainBgGrayColor;
    _aView.frame = CGRectMake(10, 10, KSystemWidth - 10 , 210);
    _aView.userInteractionEnabled = YES;
    [self.view addSubview:_aView];
    self.wordCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.left + 10,  self.textView.frame.size.height - 1, KSystemWidth - 20, 25)];
    _wordCountLabel.font = VASubTitleFont;
    _wordCountLabel.textColor = VASubTitleColor;
    self.wordCountLabel.text = @"0/300   ";
    self.wordCountLabel.backgroundColor = [UIColor whiteColor];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.textView.left + 20,  self.textView.frame.size.height - 1 + 23, [UIScreen mainScreen].bounds.size.width - 40, 1)];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:lineView];
    
    [self.view addSubview:_wordCountLabel];
    [_aView addSubview:self.textView];
    //添加一个label(问题截图（选填）)
    [self addLabelText];
    //创建collectionView进行上传图片
    [self addCollectionViewPicture];
    //添加联系方式
    [self addContactInformation];
    //提交信息的button
    [self.view addSubview:self.sendButton];
    //上传图片的button
    self.photoBtn = [[UIButton alloc]init];
    self.photoBtn.frame = CGRectMake(10 , 165, (self.aView.frame.size.width- 60) / 5, (self.aView.frame.size.width- 60) / 5);
    [_photoBtn setImage:[UIImage imageNamed:@"ic_add_image"] forState:UIControlStateNormal];
    [_photoBtn addTarget:self action:@selector(picureUpload:) forControlEvents:UIControlEventTouchUpInside];
    [self.aView addSubview:_photoBtn];
}
///图片上传
-(void)picureUpload:(UIButton *)sender{
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:5 columnNumber:5 delegate:self];
//    imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        if (photos.count) {
//            [self.photoArrayM addObjectsFromArray:photos];
//            if (self.photoArrayM.count >= 5) {
//                self.photoBtn.hidden = YES;
//            }
//            [self.collectionV reloadData];
//            self.photoBtn.frame = CGRectMake(10 * (self.photoArrayM.count + 1) + (self.aView.frame.size.width - 60) / 5 * self.photoArrayM.count, 154 - 5, (self.aView.frame.size.width - 60) / 5, (self.aView.frame.size.width - 60) / 5 + 5);
//            [self uploadLiveCover:photos];
//        }
//    };
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark-----上传封面图片
//-(void)uploadLiveCover:(NSArray *)photos{
//    NSDictionary *dic = @{@"feedback_id":[YSAccountManager getAccount].admin_id,@"type":[YSAccountManager getAccount].user_role};
//    [[YSNetworkTool shareTool]POST:kUploadFeedImageData parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (UIImage *image in photos) {
//            NSData *imageData = UIImageJPEGRepresentation(image,1.0);
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//            [formData appendPartWithFileData:imageData name:[self getrandom:dateString] fileName:fileName mimeType:@"image/jpeg"];
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if ([responseObject[@"success"]integerValue] == 1) {
//            self.imageStr = responseObject[@"data"];
//        }
//        else if ([responseObject[@"error"]integerValue] == 1001){
//            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号在其他设备登录~~" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alter show];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self showHint:@"上传失败~"];
//    }];
//}


-(NSString *)getrandom:(NSString *)fileName{
    NSString *str = [NSString stringWithFormat:@"%@_%d",fileName,arc4random()%12550+1];
    return str;
}
//-(void)updateUserInfoMessage:(NSString *)str{
//    NSDictionary *dic = @{@"image":str,@"contact":self.textField.text,@"feedback_id":[YSAccountManager getAccount].admin_id,@"system_version":[SystemInfo osVersion],@"app_version":[SystemInfo appVersion],@"content":self.textView.text,@"type":[YSAccountManager getAccount].user_role,@"manufacturer_model":[SystemInfo platform],@"network_state":[YSNetworkTool getNetworkStatesStr]};
//    [[YSNetworkTool shareTool]POST:kCreateFeedData parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject[@"success"]integerValue]==1) {
//            [self showHint:@"感谢你的反馈,我们将尽快处理或者与您联系~"];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//        else if ([responseObject[@"error"]integerValue] == 1001){
//            UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"账号在其他设备登录~~" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alter show];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self showHint:@"意见反馈失败~请稍后再试~"];
//    }];
//}
//button的frame
-(void)viewWillAppear:(BOOL)animated{
    if (self.photoArrayM.count < 5) {
        
        [self.collectionV reloadData];
        _aView.frame = CGRectMake(10, 10, KSystemWidth - 20 , 300);
        self.photoBtn.frame = CGRectMake(10 * (self.photoArrayM.count + 1) + (self.aView.frame.size.width - 60) / 5 * self.photoArrayM.count, 154 - 5, (self.aView.frame.size.width - 60) / 5, (self.aView.frame.size.width - 60) / 5 + 5);
    }else{
        [self.collectionV reloadData];
        self.photoBtn.frame = CGRectMake(0, 0, 0, 0);
    }
}
///填写意见
-(void)addLabelText{
    UILabel * labelText = [[UILabel alloc] init];
    labelText.text = @"问题截图(选填)";
    labelText.frame = CGRectMake(0, 125,[UIScreen mainScreen].bounds.size.width - 20, 20);
    labelText.font = [UIFont systemFontOfSize:14.f];
    labelText.textColor = _textView.placeholderColor;
    [_aView addSubview:labelText];
}
#pragma mark 上传图片UIcollectionView

-(void)addCollectionViewPicture{
    //创建一种布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    //设置每一个item的大小
    flowL.itemSize = CGSizeMake((self.aView.frame.size.width - 60) / 5 , (self.aView.frame.size.width - 60) / 5 );
    flowL.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
    //列
    flowL.minimumInteritemSpacing = 10;
    //行
    flowL.minimumLineSpacing = 10;
    //创建集合视图
    self.collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 148, self.aView.width-10, ([UIScreen mainScreen].bounds.size.width - 60) / 5 + 10) collectionViewLayout:flowL];
    _collectionV.backgroundColor = [UIColor whiteColor];
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    //添加集合视图
    [self.aView addSubview:_collectionV];
    //注册对应的cell
    [_collectionV registerClass:[VAPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

///添加联系方式
-(void)addContactInformation{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, self.collectionV.bottom + 30, KSystemWidth - 20 , 44)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:14.f];
    _textField.placeholder = @"   你的联系方式(手机号，QQ号或电子邮箱)";
    _textField.keyboardType = UIKeyboardTypeTwitter;
    [self.view addSubview:_textField];
}
-(VAPlaceholderTextView *)textView{
    if (!_textView) {
        _textView = [[VAPlaceholderTextView alloc]initWithFrame:CGRectMake(0, 0, KSystemWidth - 20, 100)];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = VAMainTitleFont;
        _textView.textColor = VAMainTitleColor;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.editable = YES;
        //        _textView.layer.cornerRadius = 4.0f;
        _textView.layer.borderColor = RGBColor(227,224,216).CGColor;
        //        _textView.layer.borderWidth = 0.5;
        _textView.placeholderColor = RGBColor(0x89, 0x89, 0x89);
        _textView.placeholder = @"写下你遇到的问题，或告诉我们你的宝贵意见~";
    }
    return _textView;
}

//把回车键当做退出键盘的响应键  textView退出键盘的操作
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (UIButton *)sendButton{
    
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.layer.cornerRadius = 2.0f;
        _sendButton.frame = CGRectMake(10, self.textField.bottom + 30, self.view.frame.size.width - 20, 40);
        _sendButton.backgroundColor = VAMainAppColor;
        [_sendButton setTitle:@"提交" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendFeedBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

#pragma mark 提交意见反馈
- (void)sendFeedBack{
    if (self.textView.text.length == 0) {
        
        UIAlertController *alertLength = [UIAlertController alertControllerWithTitle:@"提示" message:@"你输入的信息为空，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *suer = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertLength addAction:suer];
        [self presentViewController:alertLength animated:YES completion:nil];
    }
    else{
        BOOL isPhoneNum = [VAPredicateMethod isMobileNumber:self.textField.text];
        BOOL isEmail = [VAPredicateMethod isValidateEmail:self.textField.text];
        //验证qq未写
        
        if (isEmail != 0 || isPhoneNum != 0) {
            if (self.imageStr.length == 0) {
                return;
            }
//            [self updateUserInfoMessage:self.imageStr];
            //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"意见反馈" message:@"亲你的意见我们已经收到，我们会尽快处理" preferredStyle:UIAlertControllerStyleAlert];
            //
            //            UIAlertAction *album = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //
            //            }];
            //            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            //            [alertController addAction:album];
            //            [alertController addAction:cancel];
            //            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"通知" message:@"你输入的邮箱，QQ号或者手机号错误,请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:alertAction];
            [self presentViewController:alertC animated:YES completion:nil];
            
        }
    }
}


- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


#pragma mark CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArrayM.count == 0) {
        return 0;
    }
    else{
        return _photoArrayM.count;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VAPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.photoArrayM.count) {
        cell.photoV.image = self.photoArrayM[indexPath.item];
    }
    return cell;
}

#pragma mark textField的字数限制

//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger wordCount = textView.text.length;
    self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/300  ",(long)wordCount];
    [self wordLimit:textView];
}
#pragma mark 超过300字不能输入
-(BOOL)wordLimit:(UITextView *)text{
    if (text.text.length < 300) {
        NSLog(@"%ld",text.text.length);
        self.textView.editable = YES;
        
    }
    else{
        self.textView.editable = NO;
        
    }
    return nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
