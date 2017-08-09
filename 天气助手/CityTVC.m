//
//  cityViewCell.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "cityViewCell.h"

@implementation cityViewCell

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)]];
//    }
//    return self;
//}
//-(void)longTap:(UILongPressGestureRecognizer*)recognizer{
//    [self becomeFirstResponder];
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteItemClick:)];
//    UIMenuItem *setReminderItem = [[UIMenuItem alloc] initWithTitle:@"设置提醒" action:@selector(setReminderClick:)];
//    [menu setMenuItems:@[deleteItem,setReminderItem]];
//    [menu setTargetRect:self.bounds inView:self];
//    [menu setMenuVisible:YES animated:YES];
//}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if (action == @selector(deleteItemClick:)) {
//        return YES;
//    }else if(action == @selector(setReminderClick:)){
//        return YES;
//    }
//    return [super canPerformAction:action withSender:sender];
//}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
//-(void)deleteItemClick:(int)index{
//    NSLog(@"%s",__func__);
//    NSArray *array = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
//    NSLog(@"%lu",(unsigned long)array.count);
//    NSMutableArray *newArray = [NSMutableArray array];
//    for (int i = 0; i<array.count; i++) {
//        if (i!=index) {
//            [newArray addObject:array[i]];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"history"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSLog(@"%lu",(unsigned long)newArray.count);
//}
//-(void)setReminderClick:(int)index{
//    NSLog(@"%s",__func__);
//   // [self presentViewController:[[reminderViewController alloc] init] animated:YES completion:nil];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
