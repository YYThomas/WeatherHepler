//
//  NotificationManagerVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/28.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "NotificationManagerVC.h"
#import "NotificationTVC.h"
#import "SetNotificationVC.h"
#import "HistoryCitiesMangerVC.h"
@interface NotificationManagerVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addReminder;
@property (strong, nonatomic) IBOutlet UITableView *reminderTableView;
@end

@implementation NotificationManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reminderTableView.dataSource = self;
    self.reminderTableView.delegate = self;
    [self.backBtn addTarget:self action:@selector(pushToSettingVC) forControlEvents:UIControlEventTouchUpInside];
    [self.addReminder addTarget:self action:@selector(pushToSetNotificationVC) forControlEvents:UIControlEventTouchUpInside];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.cityName];
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationTVC *cell = [NotificationTVC initTableViewCell:self.reminderTableView andCellIdentify:@"reminderCell"];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.cityName];
    if (array) {
        NSDate *date = array[indexPath.row];
        //解析date
        NSUInteger unitFlag = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *cmpsPost = [calendar components:unitFlag fromDate:date];
        NSDateComponents *cmpsNow = [calendar components:unitFlag fromDate:[NSDate date]];
        NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],@"周天",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
        NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
        cell.weekStr.text = [weekdays objectAtIndex:theComponents.weekday];
        [cell.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        NSInteger dayPost = cmpsPost.day;
        NSInteger dayNow = cmpsNow.day;
        if ((dayPost - dayNow) == 0) {
            cell.dayStr.text = @"今天";
        }else if ((dayPost - dayNow) == 1){
            cell.dayStr.text = @"明天";
        }else{
            cell.dayStr.text = [NSString stringWithFormat:@"%ld日",(long)dayPost];
        }
        cell.timeStr.text = [NSString stringWithFormat:@"%ld:%ld",cmpsPost.hour,cmpsPost.minute];
    }
    return cell;
}
-(void)delete:(id)sender{
    NSInteger index = [self.reminderTableView indexPathForSelectedRow].row;
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:self.cityName];
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        if (i!=index) {
            [newArray addObject:array[i]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:self.cityName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.reminderTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)pushToSettingVC{
    [self presentViewController:[[HistoryCitiesMangerVC alloc] init] animated:NO completion:nil];
}
-(void)pushToSetNotificationVC{
    SetNotificationVC *srVC = [[SetNotificationVC alloc] init];
    srVC.cityName = self.cityName;
    [self presentViewController:srVC animated:NO completion:nil];
}
@end
