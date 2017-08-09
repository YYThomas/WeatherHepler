//
//  QueryCityWeatheV.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "QueryCityWeatheV.h"
#define padding 40
@interface QueryCityWeatheV()
@end
@implementation QueryCityWeatheV

+(instancetype)queryCityWeatheV{
    return [[NSBundle mainBundle] loadNibNamed:@"QueryCityWeatheV" owner:nil options:nil].lastObject;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setConstraitsForView];
}

-(void)setConstraitsForView{
    [self setConstraitsForSearchBar];
    [self setConstraitsForcitiesList];
    //[self.checkHistroy addTarget:self action:@selector(<#selector#>) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setConstraitsForSearchBar{
    self.cityTextField.placeholder = @"输入城市名称";
    [self.cityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(padding);
        make.left.equalTo(self.mas_left).offset(padding);
        make.height.equalTo(@30);
        make.width.equalTo(@250);
    }];
    [self.search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(padding);
        make.height.equalTo(@30);
        make.left.equalTo(self.cityTextField.mas_right);
        make.right.equalTo(self.mas_right).offset(-padding);
    }];
    
}

-(void)setConstraitsForFlytekBar{
    [self.iflytekSeach mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.bottom.equalTo(self.mas_bottom).offset((padding/2));
        make.left.equalTo(self.mas_left).offset(padding);
        make.right.equalTo(self.mas_right).offset(-padding);
    }];
}


-(void)setConstraitsForcitiesList{
    self.citiesList = [[HotCitiesList alloc] init];
    [self addSubview:self.citiesList];
    [self.citiesList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cityTextField.mas_bottom);
        make.bottom.equalTo(self.iflytekSeach.mas_top);
        make.left.equalTo(self.mas_left).offset(padding);
        make.right.equalTo(self.mas_right).offset(-padding);
    }];
}

@end
