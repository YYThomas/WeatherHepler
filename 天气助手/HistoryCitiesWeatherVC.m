//
//  HistoryCitiesWeatherVC.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "HistoryCitiesWeatherVC.h"
#import "HistoryCitiesMangerVC.h"
#import "HistoryCityWeatherV.h"
@interface HistoryCitiesWeatherVC ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *setBtn;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation HistoryCitiesWeatherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *historyArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    self.scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    CGFloat width = self.scrollView.frame.size.width;
    NSUInteger count = historyArray.count;
//    dispatch_group_t group  = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_main_queue();
    for (NSInteger i = 0; i<count; i++) {
//        dispatch_group_async(group, queue, ^{
//            HistoryCityWeatherV *sgView = [HistoryCityWeatherV historyCityWeatherV];
//            sgView.frame = CGRectMake(width * i, i, width, self.scrollView.frame.size.height);
//            [sgView setupViewWithCityName:historyArray[i]];
//            sgView.backgroundColor = [UIColor orangeColor];
//            [self.scrollView addSubview:sgView];
//        });
        HistoryCityWeatherV *sgView = [HistoryCityWeatherV historyCityWeatherV];
        sgView.frame = CGRectMake(width * i, i, width, self.scrollView.frame.size.height);
        [sgView setupViewWithCityName:historyArray[i]];
        sgView.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:sgView];
    }
    self.scrollView.contentSize = CGSizeMake(width * count, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = count;
    self.scrollView.delegate = self;
    [self.setBtn addTarget:self action:@selector(pushToSettigVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.pageControl.currentPage = page;
}

-(void)pushToSettigVC{
    [self presentViewController:[[HistoryCitiesMangerVC alloc] init] animated:NO completion:nil];
}
@end
