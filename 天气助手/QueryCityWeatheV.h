//
//  selectCityView.h
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotCitiesList.h"
@interface selectCityView : UIView
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UIButton *search;
@property (strong, nonatomic) IBOutlet UIButton *iflytekSeach;
@property(strong,nonatomic)hotCitiesList *citiesList;
@property (nonatomic, assign) id delegate;
+(instancetype)selectCityView;
@end

@protocol selectCityViewDelegate <NSObject>

@optional

//- (void)mhUserInfoCellDidCheckUserInfo:(MHUserInfoCell *)cell;


@end
