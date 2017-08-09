//
//  reminderTableViewCell.h
//  天气助手
//
//  Created by 俞益 on 2017/7/28.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reminderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dayStr;
@property (strong, nonatomic) IBOutlet UILabel *timeStr;
@property (strong, nonatomic) IBOutlet UILabel *weekStr;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
+ (instancetype)initTableViewCell:(UITableView *)tableVieW andCellIdentify:(NSString *)cellIdentify;
@end
