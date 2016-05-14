//
//  ShihuahuaViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "ShihuahuaViewController.h"
#import "SCNavTabBarController.h"
#import "LaughViewController.h"
#import "ReadViewController.h"

#import "LaughDetailViewController.h"

@interface ShihuahuaViewController ()

@end

@implementation ShihuahuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];

    [self initSCNav];
}

- (void)initSCNav
{
    LaughViewController *laughVC = (id)[self initViewControllerWithStoryBoardID:@"laughvc"];
    laughVC.title = @"搞笑秀";
    
    ReadViewController *readVC = (id)[self initViewControllerWithStoryBoardID:@"readvc"];
    readVC.title = @"微阅读";
    
    SCNavTabBarController * navTabBarController = [[SCNavTabBarController alloc] init];
    //注意顺序 由左到右
    navTabBarController.subViewControllers = @[laughVC,readVC];
        
    navTabBarController.navTabBarLineColor = [UIColor lightGrayColor];
    //展示
    [navTabBarController addParentController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
