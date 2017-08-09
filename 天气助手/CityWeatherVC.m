//
//  CityWeatherVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "CityWeatherVC.h"
#import "AFNetworking.h"
#import "QueryCityWeatheVC.h"
@interface CityWeatherVC ()
@end

@implementation CityWeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dtWeatherView = [DetailWeatherV detailWeatherV];
    self.dtWeatherView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.dtWeatherView.backgroundColor = [UIColor orangeColor];
    
    [self.dtWeatherView.returnBtn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dtWeatherView];
}

-(void)setupWithCityName{
    AFHTTPSessionManager *manager  = [AFHTTPSessionManager manager];
    NSDictionary *parameter=@{@"city": self.cityName};
    //    1.沙盒存储只能存储基本类型,int string 字典 数组等 均是不可变的
    //    2.因此在存储时候,将例子中的数据源数组 转化为了不可变数据
    //    3.当再次获取的时候,其实获取的数据源数组本质是不可变数组
    
    /*新构思：会存在出现两个相同城市的情况
     */
    NSMutableArray *historyCitiesArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"history"];
    if (!historyCitiesArray) {
        historyCitiesArray = [NSMutableArray arrayWithObjects:self.cityName, nil];
        [[NSUserDefaults standardUserDefaults] setObject:historyCitiesArray forKey:@"history"];
    }else{
        NSMutableArray *history = [[NSMutableArray alloc] initWithArray:historyCitiesArray];
        int i = 0;
        for(;i<history.count;i++) {
            if ([self.cityName isEqualToString:history[i]]) {
                break;
            }
        }
        if (i==history.count) {
            [history addObject:self.cityName];
            [[NSUserDefaults standardUserDefaults] setObject:history forKey:@"history"];
        }
    }
    NSString *urlStr = [NSString stringWithFormat:@"http://www.sojson.com/open/api/weather/json.shtml?%@",self.cityName];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSString *urlStr = @"http://www.sojson.com/open/api/weather/json.shtml?";
    [manager GET:urlStr parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict1 = (NSDictionary *)responseObject;
        NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
        self.dtWeatherView.cityName.text = parameter[@"city"];
        [self.dtWeatherView.cityName sizeToFit];
        self.dtWeatherView.currentTemp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
        NSDate *dateNow = [NSDate date];
        NSInteger unitFlag = NSCalendarUnitMonth;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:unitFlag fromDate:dateNow];
        NSString *dateStr = [NSString stringWithFormat:@"%ld月%@",(long)comps.month,dict2[@"date"]];
        self.dtWeatherView.date.text = dateStr;
        [self.dtWeatherView.date sizeToFit];
        self.dtWeatherView.weather.text = dict2[@"type"];
        self.dtWeatherView.lowestTemp.text = dict2[@"low"];
        self.dtWeatherView.highestTemp.text = dict2[@"high"];
        self.dtWeatherView.windDirection.text = dict2[@"fengxiang"];
        [self.dtWeatherView.windDirection sizeToFit];
        self.dtWeatherView.windStrength.text = dict2[@"fengli"];
        if (self.dtWeatherView.lowestTemp.text == nil) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取天气失败，请重试" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                QueryCityWeatheVC *scVC = [[QueryCityWeatheVC alloc] init];
                [self presentViewController:scVC animated:NO completion:nil];
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了取消");
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            NSString *key = [NSString stringWithFormat:@"%@weather",self.cityName];
            [[NSUserDefaults standardUserDefaults] setObject:dict1 forKey:key];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

-(void)setupFromSandBoxWithKey:(NSString *)key{
    //[self.dtWeatherView.returnBtn removeFromSuperview];
    NSDictionary *dict1 = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSDictionary *dict2 = dict1[@"data"][@"forecast"][0];
    self.dtWeatherView.cityName.text = dict1[@"data"][@"city"];
    NSLog(@"%@",self.dtWeatherView.cityName);
    [self.dtWeatherView.cityName sizeToFit];
    self.dtWeatherView.currentTemp.text = [NSString stringWithFormat:@"%@°C",dict1[@"data"][@"wendu"]];
    self.dtWeatherView.date.text = dict2[@"date"];
    
    [self.dtWeatherView.date sizeToFit];
    self.dtWeatherView.weather.text = dict2[@"type"];
    self.dtWeatherView.lowestTemp.text = dict2[@"low"];
    self.dtWeatherView.highestTemp.text = dict2[@"high"];
    self.dtWeatherView.windDirection.text = dict2[@"fengxiang"];
    [self.dtWeatherView.windDirection sizeToFit];
    self.dtWeatherView.windStrength.text = dict2[@"fengli"];
    
}

-(void)returnBack{
    QueryCityWeatheVC *scVC = [[QueryCityWeatheVC alloc] init];
    [self presentViewController:scVC animated:NO completion:nil];
}
@end
