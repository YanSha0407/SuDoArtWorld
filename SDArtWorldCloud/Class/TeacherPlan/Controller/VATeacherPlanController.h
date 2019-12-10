//
//  VATeacherPlanController.h
//  SDArtWorldCloud
//
//  Created by metis on 2019/11/22.
//  Copyright © 2019 Sudo. All rights reserved.
//

#import "VABaseViewController.h"
#import <JTCalendar/JTCalendar.h>
NS_ASSUME_NONNULL_BEGIN

@interface VATeacherPlanController : VABaseViewController<JTCalendarDelegate>
@property (strong, nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end

NS_ASSUME_NONNULL_END
