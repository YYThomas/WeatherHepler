//
//  singleView.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//
#import "singleView.h"
#import "AFNetworking.h"
@implementation singleView
+(instancetype)singleView{
    return  [[NSBundle mainBundle] loadNibNamed:@"singleView" owner:nil options:nil].lastObject;
}
-(void)setupViewWithCityName:(NSString *)cityName{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    NSDictionary *parameter=@{@"city":cityName};
//    for (bool isLoopAgain = YES; isLoopAgain; ) {
//        __block int isLoopAgainBlock = isLoopAgain;
//        [manager GET:@"http://www.sojson.com/open/api/weather/json.shtml?" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSDictionary *dict1 = (NSDictionary *)responseObject;
//            NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
//            self.cityName.text = parameter[@"city"];
//            [self.cityName sizeToFit];
//            self.temp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
//            self.date.text = dict2[@"date"];
//            [self.date sizeToFit];
//            self.weather.text = dict2[@"type"];
//            self.lowestTemp.text = dict2[@"low"];
//            self.highestTemp.text = dict2[@"high"];
//            self.windDirection.text = dict2[@"fengxiang"];
//            [self.windDirection sizeToFit];
//            self.windStrength.text = dict2[@"fengli"];
//            if (dict1[@"status"] == 200) {
//                isLoopAgainBlock = NO;
//            }
//            NSLog(@"city:%@,temp: %@,dict1: %@",parameter[@"city"],self.temp,dict1);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"请求失败");
//        }];
//        isLoopAgain = isLoopAgainBlock;
//    }
    NSString *urlStr = [NSString stringWithFormat:@"http://www.sojson.com/open/api/weather/json.shtml?%@",cityName];
    NSLog(@"未变之前cityName:%@",cityName);
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict1 = (NSDictionary *)responseObject;
        NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
        self.cityName.text = parameter[@"city"];
        [self.cityName sizeToFit];
        self.date.text = dict2[@"date"];
        [self.date sizeToFit];
        self.temp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
        self.weather.text = dict2[@"type"];
        self.lowestTemp.text = dict2[@"low"];
        self.highestTemp.text = dict2[@"high"];
        self.windDirection.text = dict2[@"fengxiang"];
        [self.windDirection sizeToFit];
        self.windStrength.text = dict2[@"fengli"];
        NSLog(@"urlStr:%@city:%@ dict1:%@",urlStr,self.cityName.text,dict1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }]; 
}
@end
