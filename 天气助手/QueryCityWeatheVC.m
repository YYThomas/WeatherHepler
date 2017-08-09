//
//  searchCityViewController.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "searchCityViewController.h"
#import "selectCityView.h"
#import "cityWeatherViewController.h"
@interface searchCityViewController ()<HotCitiesListDelegate>
@property(nonatomic,strong)selectCityView *scView;
@end

@implementation searchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.scView = [selectCityView selectCityView];
    self.scView.citiesList.delegate = self;
    [self.view addSubview:self.scView];
    [self.scView.search addTarget:self action:@selector(pushToDetailWeatherViewControllerWithCityName) forControlEvents:UIControlEventTouchUpInside];
}
-(void)pushToDetailWeatherViewControllerWithCityName{
    cityWeatherViewController *cwVC = [[cityWeatherViewController alloc] init];
    NSString *str = self.scView.cityTextField.text;
    cwVC.cityName = str;
    [cwVC setupWithCityName];
    [self presentViewController:cwVC animated:NO completion:nil];
}
-(void)pushToVC:(NSString *)str{
    cityWeatherViewController *cwVC = [[cityWeatherViewController alloc] init];
    cwVC.cityName = str;
    [cwVC setupWithCityName];
    [self presentViewController:cwVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
