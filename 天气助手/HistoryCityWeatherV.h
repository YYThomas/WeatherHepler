//
//  HistoryCityWeatherV..h
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCityWeatherV : UIView
+(instancetype)historyCityWeatherV;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *weather;
@property (strong, nonatomic) IBOutlet UILabel *temp;
@property (strong, nonatomic) IBOutlet UILabel *date;
@property (strong, nonatomic) IBOutlet UILabel *lowestTemp;
@property (strong, nonatomic) IBOutlet UILabel *highestTemp;
@property (strong, nonatomic) IBOutlet UILabel *windDirection;
@property (strong, nonatomic) IBOutlet UILabel *windStrength;

-(void)setupViewWithCityName:(NSString *)cityName;
@end
