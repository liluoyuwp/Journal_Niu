//
//  ZhitanhuiViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "ZhitanhuiViewController.h"
#import "WangqiModel.h"
#import "UIImageView+WebCache.h"
#import "GentieViewController.h"

@interface ZhitanhuiViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *gentieButton;
@property (weak, nonatomic) IBOutlet UIButton *wangqiButton;

@end

@implementation ZhitanhuiViewController
{
    WangqiModel *_model;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}

- (void)initData {

}

- (void)initUI {
    self.view.hidden = YES;
}

- (void)requestData {
    WS(weakSelf);
    [WangqiModel getWangqiDataWithUrlString:PARTICPANCE_URL success:^(WangqiModel *model) {
        
        _model = model;
        
        [weakSelf refreshUI];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)refreshUI {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"缺省图"]];
    self.titleLabel.text = _model.title;
    self.textView.text = [NSString stringWithFormat:@"        %@,",_model.content];
    [self.gentieButton setTitle:[NSString stringWithFormat:@"跟帖     %@",_model.count] forState:UIControlStateNormal];
    self.view.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"gentie"]) {
        GentieViewController *vc = segue.destinationViewController;
        vc.gentie_id = _model.gentie_id;
        vc.gentie_title = _model.title;
    }

}

@end
