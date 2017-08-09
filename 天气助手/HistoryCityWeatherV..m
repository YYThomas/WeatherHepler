//
//  HistoryCityWeatherV.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//
#import "HistoryCityWeatherV.h"
#import "AFNetworking.h"
@implementation HistoryCityWeatherV
+(instancetype)historyCityWeatherV{
    return  [[NSBundle mainBundle] loadNibNamed:@"HistoryCityWeatherV" owner:nil options:nil].lastObject;
}
-(void)setupViewWithCityName:(NSString *)cityName{
//    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
//    NSDictionary *parameter=@{@"city":cityName};
//    NSString *urlStr = [NSString stringWithFormat:@"http://www.sojson.com/open/api/weather/json.shtml?%@",cityName];
//    NSLog(@"未变之前cityName:%@",cityName);
//    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict1 = (NSDictionary *)responseObject;
//        NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
//        self.cityName.text = parameter[@"city"];
//        [self.cityName sizeToFit];
//        self.date.text = dict2[@"date"];
//        [self.date sizeToFit];
//        self.temp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
//        self.weather.text = dict2[@"type"];
//        self.lowestTemp.text = dict2[@"low"];
//        self.highestTemp.text = dict2[@"high"];
//        self.windDirection.text = dict2[@"fengxiang"];
//        [self.windDirection sizeToFit];
//        self.windStrength.text = dict2[@"fengli"];
//        NSLog(@"urlStr:%@city:%@ dict1:%@",urlStr,self.cityName.text,dict1);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败");
//    }];
    //从沙盒里解析出数据
    NSString *key = [NSString stringWithFormat:@"%@weather",cityName];
    NSLog(@"cityName%@",cityName);
    NSDictionary *dict1 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
    self.cityName.text = cityName;
    [self.cityName sizeToFit];
    NSDate *dateNow = [NSDate date];
    NSInteger unitFlag = NSCalendarUnitMonth;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlag fromDate:dateNow];
    NSString *dateStr = [NSString stringWithFormat:@"%ld月%@",(long)comps.month,dict2[@"date"]];
    self.date.text = dateStr;
    [self.date sizeToFit];
    self.temp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
    self.weather.text = dict2[@"type"];
    self.lowestTemp.text = dict2[@"low"];
    self.highestTemp.text = dict2[@"high"];
    self.windDirection.text = dict2[@"fengxiang"];
    [self.windDirection sizeToFit];
    self.windStrength.text = dict2[@"fengli"];
    NSLog(@"dict1%@",dict1);
}

@end
