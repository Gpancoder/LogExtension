//
//  DatePickerView.h
//  Jujiawuyou
//
//  Created by dh on 16/6/15.
//  Copyright © 2016年 HaoQuan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DatePickerViewDelegate <NSObject>

-  (void)didSeleteDay:(NSString *)day beginTime:(NSString *)beginTime;

@end




@interface DatePickerView : UIView


@property(nonatomic,weak)   id<DatePickerViewDelegate> delegate;

@property (strong,nonatomic)UIPickerView *pick;

@property (strong, nonatomic) NSArray *yearArray;//年份
@property (strong, nonatomic) NSArray *dayArray;//月份
@property (strong, nonatomic) NSArray *weekArray; // 星期几
@property (strong, nonatomic) NSArray *timeBeginArray; //开始事件






@property (weak,nonatomic) UILabel *yearLab;
@property (weak,nonatomic)UIButton *leftBtn;//取消
@property (weak,nonatomic)UIButton *rightBtn;
@end
