//
//  QueryCityWeatheVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "QueryCityWeatheVC.h"
#import "QueryCityWeatheV.h"
#import "CityWeatherVC.h"
#import "HistoryCitiesWeatherVC.h"
#import "BBVoiceRecordController.h"
#import "UIColor+BBVoiceRecord.h"
#import "BBHoldToSpeakButton.h"

#define kFakeTimerDuration       0.2
#define kMaxRecordDuration       10     //最长录音时长
#define kRemainCountingDuration  10     //剩余多少秒开始倒计时
@interface QueryCityWeatheVC ()<HotCitiesListDelegate>
@property(nonatomic,strong)QueryCityWeatheV *scView;
//语音语义理解对象
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;
@property (nonatomic, strong) BBVoiceRecordController *voiceRecordCtrl;
@property (nonatomic, assign) BBVoiceRecordState currentRecordState;
@end

@implementation QueryCityWeatheVC
- (void)viewDidLoad {
    [super viewDidLoad];
//    iOS官方demo有问题，该功能无法使用，报错：14002未知错误！无法使用语义理解接口
    _iFlySpeechUnderstander = [IFlySpeechUnderstander sharedInstance];
    _iFlySpeechUnderstander.delegate = self;
    self.view.backgroundColor = [UIColor redColor];
    self.scView = [QueryCityWeatheV queryCityWeatheV];
    [self.scView.iflytekSeach addTarget:self action:@selector(onlinRecBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    self.scView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.scView.checkHistroy addTarget:self action:@selector(pushToHistoryCitiesWeatherVC) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *historyArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    if (historyArray == nil) {
        [self.scView.checkHistroy removeFromSuperview];
    }
    [self.view addSubview:self.scView];
    self.scView.citiesList.delegate = self;
    [self.scView.search addTarget:self action:@selector(pushToDetailWeatherViewControllerWithCityName) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)onlinRecBtnHandler{
    //设置为麦克风输入语音
    [_iFlySpeechUnderstander setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    bool ret = [_iFlySpeechUnderstander startListening];
    if (ret) {
        NSLog(@"启动识别服务成功");
    }else{
        NSLog(@"启动识别服务失败，请稍后重试");
    }
}
-(void)onError:(IFlySpeechError *)errorCode{
    
}
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    
}
-(void)pushToHistoryCitiesWeatherVC{
    HistoryCitiesWeatherVC *hcVC = [[HistoryCitiesWeatherVC alloc] init];
    [self presentViewController:hcVC animated:NO completion:nil];
}
-(void)pushToDetailWeatherViewControllerWithCityName{
    CityWeatherVC *cwVC = [[CityWeatherVC alloc] init];
    NSString *str = self.scView.cityTextField.text;
    cwVC.cityName = str;
    [cwVC setupWithCityName];
    [self presentViewController:cwVC animated:NO completion:nil];
}
-(void)pushToVC:(NSString *)str{
    CityWeatherVC *cwVC = [[CityWeatherVC alloc] init];
    cwVC.cityName = str;
    [cwVC setupWithCityName];
    [self presentViewController:cwVC animated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
