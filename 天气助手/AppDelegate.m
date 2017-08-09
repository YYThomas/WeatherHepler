//
//  AppDelegate.m
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "AppDelegate.h"
#import "QueryCityWeatheVC.h"
#import "HistoryCitiesWeatherVC.h"
#import "CityWeatherVC.h"
#import "iflyMSC/IFlyMSC.h"
#import <UserNotifications/UserNotifications.h>
#define APPID_VALUE           @"5979519f"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //判断是否有查询记录
    NSMutableArray *historyArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    if (historyArray.count == 0) {
        self.window.rootViewController = [[QueryCityWeatheVC alloc] init];
    }else{
        self.window.rootViewController = [[HistoryCitiesWeatherVC alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"YY:允许通知触发");
        }else{
            NSLog(@"YY:不允许通知触发");
        }
    }];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//用于后台和程序退出，以前的是分开写的
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSString *key = [userInfo objectForKey:@"cityName"];
    CityWeatherVC *cw = [[CityWeatherVC alloc] init];
    self.window.rootViewController = cw;
    [self.window makeKeyAndVisible];
    [cw setupFromSandBoxWithKey:key];
    completionHandler();//必须要写否则要报错
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
//        
//    }
//    else {
//        // 判断为本地通知
//        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
//    }
}
@end
