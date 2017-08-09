//
//  QueryCityWeatheV.h
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCitiesList.h"
#import "BBHoldToSpeakButton.h"
@interface QueryCityWeatheV : UIView
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UIButton *search;
@property (strong, nonatomic) IBOutlet BBHoldToSpeakButton *iflytekSeach;

@property (strong, nonatomic) IBOutlet UIButton *checkHistroy;
@property(strong,nonatomic)HotCitiesList *citiesList;
@property (nonatomic, assign) id delegate;
+(instancetype)queryCityWeatheV;
@end
