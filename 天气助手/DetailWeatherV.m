//
//  detailWeatherView.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "detailWeatherView.h"
#import "cityWeatherViewController.h"
@implementation detailWeatherView
+(instancetype)detailWeatherView{
    return [[NSBundle mainBundle] loadNibNamed:@"detailWeatherView" owner:nil options:nil].lastObject;
}

@end
