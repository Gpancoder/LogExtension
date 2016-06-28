//
//  DatePickerView.m
//  Jujiawuyou
//
//  Created by dh on 16/6/15.
//  Copyright © 2016年 HaoQuan. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@end
@implementation DatePickerView




//获取周信息
- (NSString *)getWeekDayWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[day intValue]];
    [_comps setMonth:[month intValue]];
    [_comps setYear:[year intValue]];


    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *_date = [calendar dateFromComponents:_comps];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:_date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


- (NSInteger)getNumOfDayWithYear:(NSString *)year month:(NSString *)month {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
     [_comps setYear:[year intValue]];
        [_comps setMonth:[month intValue]];
        NSDate *_date = [calendar dateFromComponents:_comps];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitYear inUnit:NSCalendarUnitMonth forDate:_date];
    
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}
// 初始化数组
- (NSArray *)setWeekArray{


    NSMutableArray *dayArray = [NSMutableArray array];
    

    for ( int i = 0; i<7; i++) {
        NSDate *currentDate = [NSDate date];//获取当前时间，日期
        
        NSDate *date = [NSDate dateWithTimeInterval:86400*i sinceDate:currentDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY/MM/dd"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        NSArray *array = [dateString componentsSeparatedByString:@"/"];
        
        NSString * week = [self getWeekDayWithYear:array[0] month:array[1] day:array[2]];
        NSString *str = [NSString stringWithFormat:@"%@年%@月%@日 %@",array[0],array[1],array[2],week];
        [dayArray addObject:str];
        
    }


    
    return dayArray.copy;
   
    
}

- (void)setTimeArray {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 9; i <= 18; i++) {
        
        [array addObject:[NSString stringWithFormat:@"%d:00",i]];
        [array addObject:[NSString stringWithFormat:@"%d:30",i]];
    }
    self.timeBeginArray = array.copy;
  
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [self creatPickerView];
        [self setTimeArray];
      self.dayArray =[self setWeekArray];
    }
    return self;
}


- (void)creatPickerView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
    view.backgroundColor = UIColorFromRGB(0xDCDCDC);
    [self addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    btn.frame = CGRectMake(5, 0, 40, 32);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [view addSubview:btn];
      self.leftBtn = btn;
    
   UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, self.frame.size.width - 80, 32)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = UIColorFromRGB(0x666666);
    lab.textAlignment = NSTextAlignmentCenter;
    self.yearLab = lab;
    [view addSubview:lab];
    
   UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = button;
    button.frame = CGRectMake(view.frame.size.width-45,0, 40, 32);
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [view addSubview:button];
    
    self.pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 32, self.frame.size.width, self.frame.size.height - 32)];
    self.pick.delegate = self;
    self.pick.dataSource = self;
    self.pick.showsSelectionIndicator=YES;
    
    [self addSubview:self.pick];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
//        截取 年到后面的字符
        return [[self.dayArray objectAtIndex:row] substringFromIndex:5];
    }else {
        return [self.timeBeginArray objectAtIndex:row];
    }
}


//返回显示的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.dayArray.count;
    }else {
          return self.timeBeginArray.count;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
         return self.frame.size.width *0.7;
    }else
        return self.frame.size.width *0.3;
    
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

//自定义pickerView视图
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.yearLab.text = [self.dayArray[row] substringToIndex:4];
    }

    
    if ([self.delegate respondsToSelector:@selector(didSeleteDay:beginTime:)]) {
         [self.delegate didSeleteDay:[self.dayArray objectAtIndex:[pickerView selectedRowInComponent:0] ] beginTime:[self.timeBeginArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
    }
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
