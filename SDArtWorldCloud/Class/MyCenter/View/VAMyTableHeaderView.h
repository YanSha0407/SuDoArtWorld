//
//  VAMyTableHeaderView.h
//  VagaryArtWorldProject
//
//  Created by metis2017 on 2019/8/14.
//  Copyright © 2019年 metis2017. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ClickUserHeaderView <NSObject>
-(void)clickUserHeaderView;
@end

@interface VAMyTableHeaderView : UIView

@property(nonatomic,assign)id <ClickUserHeaderView> VADelegate;

@end

NS_ASSUME_NONNULL_END
