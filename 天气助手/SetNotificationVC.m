//  setReminderViewController.m
//  天气助手
//
//  Created by 俞益 on 2017/7/28.
//  Copyright © 2017年 俞益. All rights reserved.
#import "setReminderViewController.h"
#import "reminderViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "AFNetworking.h"
@interface setReminderViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation setReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveBtn addTarget:self action:@selector(saveDateToSandBox) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn addTarget:self action:@selector(pushToRemindVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)saveDateToSandBox{
    NSDate *remindDate = self.datePicker.date;
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.cityName];
    if (!array) {
        NSArray *array = [NSArray arrayWithObjects:remindDate, nil];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:self.cityName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        NSMutableArray *mutaArray = [NSMutableArray arrayWithArray:array];
        [mutaArray addObject:remindDate];
        [[NSUserDefaults standardUserDefaults] setObject:mutaArray forKey:self.cityName];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    NSDictionary *parameter=@{@"city": self.cityName};
    [manager GET:@"http://www.sojson.com/open/api/weather/json.shtml?" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        NSDictionary *dict1 = (NSDictionary *)responseObject;
        NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
        //保存到沙盒
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
        
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *key = [NSString stringWithFormat:@"%@%@",self.cityName,dateStr];
        [[NSUserDefaults standardUserDefaults] setObject:dict1 forKey:key];
        //触发通知
        content.title = [NSString stringWithFormat:@"%@天气情况简报",self.cityName];
        content.body = [NSString stringWithFormat:@"今日天气%@,当前温度温度%@",dict2[@"type"],dict1[@"data"][@"wendu"]];
        content.sound = [UNNotificationSound defaultSound];
        content.userInfo = [NSDictionary dictionaryWithObject:key forKey:@"cityName"];
        NSInteger unitFlag = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unitFlag fromDate:remindDate];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:cmps repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:key content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"设置成功");
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}
-(void)pushToRemindVC{
    reminderViewController *rmVC = [[reminderViewController alloc] init];
    rmVC.cityName = self.cityName;
    [self presentViewController:rmVC animated:NO completion:nil];
}
@end
