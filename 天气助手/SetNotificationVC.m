//  SetNotificationVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/28.
//  Copyright © 2017年 俞益. All rights reserved.
#import "SetNotificationVC.h"
#import "NotificationManagerVC.h"
#import <UserNotifications/UserNotifications.h>
#import "AFNetworking.h"
@interface SetNotificationVC ()
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIButton *saveBtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation SetNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveBtn addTarget:self action:@selector(clickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtn addTarget:self action:@selector(pushToRemindVC) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"YYDebug:This a test");
}

-(void)clickSaveBtn{
    NSDate *remindDate = self.datePicker.date;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"天气助手" message:@"新提醒设置成功！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
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
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    [self setLocalNotificationWithDate:remindDate];
}

-(void)setLocalNotificationWithDate:(NSDate *)remindDate{
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
    NotificationManagerVC *rmVC = [[NotificationManagerVC alloc] init];
    rmVC.cityName = self.cityName;
    [self presentViewController:rmVC animated:NO completion:nil];
}
@end
