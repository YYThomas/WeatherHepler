//
//  settingViewController.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "settingViewController.h"
#import "cityViewCell.h"
#import "reminderViewController.h"
#import "historyCitiesViewController.h"
#import "QueryCityWeatheVC.h"
@interface settingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UITableView *cityTableView;
@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate = self;
    [self.backBtn addTarget:self action:@selector(pushToHistoryVC) forControlEvents:UIControlEventTouchUpInside];
    [self.addBtn addTarget:self action:@selector(pushToSearchVC) forControlEvents:UIControlEventTouchUpInside];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
    return array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    cityViewCell *cell = [[cityViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)]];
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

-(void)longTap:(UILongPressGestureRecognizer*)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        cityViewCell *cell = (cityViewCell *)recognizer.view;
        [cell becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteItemClick:)];
        UIMenuItem *setReminderItem = [[UIMenuItem alloc] initWithTitle:@"设置提醒" action:@selector(setReminderClick:)];
        [menu setMenuItems:@[deleteItem,setReminderItem]];
        [menu setTargetRect:cell.frame inView:self.view];
        [menu setMenuVisible:YES animated:YES];
    }
}

-(void)deleteItemClick:(id)sender{
    NSInteger index = [self.cityTableView indexPathForSelectedRow].row;
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
    NSMutableArray *newArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        if (i!=index) {
            [newArray addObject:array[i]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"history"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.cityTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)setReminderClick:(id)sender{
    NSInteger index = [self.cityTableView indexPathForSelectedRow].row;
    reminderViewController *rmVC = [[reminderViewController alloc] init];
    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
    rmVC.cityName = array[index];
    [self presentViewController:rmVC animated:YES completion:nil];
}
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)pushToHistoryVC{
    [self presentViewController:[[historyCitiesViewController alloc] init] animated:YES completion:nil];
}
- (void)pushToSearchVC{
    [self presentViewController:[[QueryCityWeatheVC alloc] init] animated:YES completion:nil];
}
@end
