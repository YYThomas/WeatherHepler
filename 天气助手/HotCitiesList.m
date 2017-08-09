//
//  hotCitiesList.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "hotCitiesList.h"
#define Width self.frame.size.width
#define Height self.frame.size.height
@implementation hotCitiesList
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self initHotCitiesView];
}
-(void)initHotCitiesView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hotCities.plist" ofType:nil];
    NSArray *cityArray = [NSArray arrayWithContentsOfFile:path];
    float btnWidth = Width/7.0;
    float btnHeight = Height/13.0;
    int row = 0 ,col = 0;
    for (int i = 0;i<cityArray.count;i++) {
        int index = i % 4;
        if(index==0&&i==0){
            row = 0;
            col = 0;
        }else{
            if (index == 0) {
                row = row + 1;
                col = 0 ;
            }else{
                col = col + 1;
            }
        }
        float btnX = 2*btnWidth * col;
        float btnY = 2*btnHeight * row;
        //计算每个btn 的位置和大小
        UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        [cityBtn setFrame:frame];
        [cityBtn setTitle:cityArray[i] forState:UIControlStateNormal];
        cityBtn.backgroundColor = [UIColor grayColor];
        [cityBtn sizeToFit];
        [cityBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cityBtn];
    }
}
-(void)click:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([_delegate respondsToSelector:@selector(pushToVC:)]) {
        [_delegate pushToVC:btn.titleLabel.text];
    }
    NSLog(@"点击了");
}
@end
