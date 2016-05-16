//
//  GrowupViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "GrowupViewController.h"

@interface GrowupViewController ()

@end

@implementation GrowupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.urlString = [NSString stringWithFormat:YILIN_GROWUP_URL,(NSInteger)0];
        self.type = YILIN_CHENGZHANG;
    }
    return self;
}

- (NSString *)getRequestUrl {
    return [NSString stringWithFormat:YILIN_GROWUP_URL,self.page];
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
