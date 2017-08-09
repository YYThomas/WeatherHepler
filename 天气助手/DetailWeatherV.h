//
//  detailWeatherView.h
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailWeatherView : UIView
@property (strong, nonatomic) IBOutlet UIButton *returnBtn;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *weather;
@property (strong, nonatomic) IBOutlet UILabel *currentTemp;

@property (strong, nonatomic) IBOutlet UILabel *lowestTemp;
@property (strong, nonatomic) IBOutlet UILabel *highestTemp;
@property (strong, nonatomic) IBOutlet UILabel *windDirection;
@property (strong, nonatomic) IBOutlet UILabel *windStrength;

+(instancetype)detailWeatherView;
@end
