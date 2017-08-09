//
//  hotCitiesList.h
//  天气助手
//
//  Created by 俞益 on 2017/7/26.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotCitiesList : UIView
@property(assign,nonatomic)id delegate;
-(instancetype)init;
@end
@protocol hotCitiesListDelegate <NSObject>

-(void)pushToVC:(NSString *)str;

@end
