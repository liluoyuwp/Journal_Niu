//
//  YILINViewController.m
//  ;
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "YILINViewController.h"
#import "NewsViewController.h"
#import "SoupViewController.h"
#import "HorizonViewController.h"
#import "GrowupViewController.h"
#import "ArtViewController.h"
#import "LifeViewController.h"
#import "SCNavTabBarController.h"

@interface YILINViewController ()

@end

@implementation YILINViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self initSCNav];
}

- (void)initSCNav
{
    
    NewsViewController * newsVC = [[NewsViewController alloc] init];
    newsVC.title = @"最新";
    
    SoupViewController * soupVC = [[SoupViewController alloc] init];
    soupVC.title = @"心灵鸡汤";
    
    HorizonViewController * HorizonVC = [[HorizonViewController alloc] init];
    HorizonVC.title = @"视界";
    
    GrowupViewController * growupVC = [[GrowupViewController alloc] init];
    growupVC.title = @"成长";
    
    ArtViewController * artVC = [[ArtViewController alloc] init];
    artVC.title = @"文艺志";
    
    LifeViewController * lifeVC = [[LifeViewController alloc] init];
    lifeVC.title = @"乐活";
    
    SCNavTabBarController * navTabBarController = [[SCNavTabBarController alloc] init];
    //注意顺序 由左到右
    navTabBarController.subViewControllers = @[newsVC,soupVC,HorizonVC,growupVC,artVC,lifeVC];
    
    navTabBarController.showArrowButton = YES;
        
    navTabBarController.navTabBarLineColor = [UIColor lightGrayColor];
    //展示
    [navTabBarController addParentController:self];
}


@end
