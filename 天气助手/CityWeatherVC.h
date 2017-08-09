//
//  CityWeatherVC.h
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailWeatherV.h"
@interface CityWeatherVC : UIViewController
@property(nonatomic,assign)NSString *cityName;
@property(nonatomic,strong)DetailWeatherV *dtWeatherView;
-(void)setupWithCityName;
-(void)setupFromSandBoxWithKey:(NSString *)key;
@end
