//
//  NotificationTVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/28.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "NotificationTVC.h"

@implementation NotificationTVC

+ (instancetype)initTableViewCell:(UITableView *)tableVieW andCellIdentify:(NSString *)cellIdentify{
    NotificationTVC *cell = [tableVieW dequeueReusableCellWithIdentifier:cellIdentify];
    if (cell == nil) {
        [cell.dayStr sizeToFit];
        [cell.timeStr sizeToFit];
        [cell.weekStr sizeToFit];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotificationTVC" owner:nil options:nil] lastObject];
    }//由于是从xib中创建，所以调用loadNibName的方法
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
