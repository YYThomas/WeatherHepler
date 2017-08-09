//
//  historyCitiesViewController.m
//  天气助手
//
//  Created by 俞益 on 2017/7/27.
//  Copyright © 2017年 俞益. All rights reserved.
//

#import "historyCitiesViewController.h"
#import "HistoryCitiesMangerVC.h"
#import "singleView.h"
@interface historyCitiesViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *setBtn;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation historyCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableArray *historyArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    CGFloat width = self.scrollView.frame.size.width;
    NSUInteger count = historyArray.count;
    dispatch_group_t group  = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_main_queue();
    for (NSInteger i = 0; i<count; i++) {
        dispatch_group_async(group, queue, ^{
            singleView *sgView = [singleView singleView];
            sgView.frame = CGRectMake(width * i, i, width, self.scrollView.frame.size.height);
            [sgView setupViewWithCityName:historyArray[i]];
            [self.scrollView addSubview:sgView];
        });
    }
    self.scrollView.contentSize = CGSizeMake(width * count, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = count;
    self.scrollView.delegate = self;
    [self.setBtn addTarget:self action:@selector(pushToSettigVC) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)setViewWithCityName:(id)object{
//    //只能显示一个信息
//    NSDictionary *dict = (NSDictionary *)object;
//    NSNumber *number1 = [dict objectForKey:@"index"];
//    int index = [number1 intValue];
//    
//    NSNumber *number2 = [dict objectForKey:@"index"];
//    float width = [number2 floatValue];
//    
//    NSString *cityName = [dict objectForKey:@"cityName"];
//    singleView *sgView = [singleView singleView];
//    sgView.frame = CGRectMake(width * index, index, width, self.scrollView.frame.size.height);
//    [sgView setupViewWithCityName:cityName];
//    [self.scrollView addSubview:sgView];
//}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.pageControl.currentPage = page;
}
-(void)pushToSettigVC{
    [self presentViewController:[[HistoryCitiesMangerVC alloc] init] animated:NO completion:nil];
}
@end
