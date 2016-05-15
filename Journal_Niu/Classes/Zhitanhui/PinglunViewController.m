//
//  PinglunViewController.m
//  Journal_Niu
//
//  Created by WP on 16/5/15.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "PinglunViewController.h"
#import "GentieModel.h"

@interface PinglunViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation PinglunViewController
{
    UILabel *_placeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.textView becomeFirstResponder];
    
    _placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, CGRectGetWidth(self.textView.frame), 21)];
    _placeLabel.text = @"请输入您的评论,最多140个字...";
    _placeLabel.textColor = [UIColor lightGrayColor];
    _placeLabel.backgroundColor = [UIColor clearColor];
    _placeLabel.hidden = NO;
    [self.textView addSubview:_placeLabel];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    _placeLabel.hidden = self.textView.hasText;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self.view endEditing:YES];
        [self pinglunButton:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark - bar button actions.
- (IBAction)dismissPinglunControllerView:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pinglunButton:(id)sender {
    
    if (self.textView.text.length > 140) {
        [WPAlertView showAlertWithMessage:@"您的评论不符要求(长度不应超过140字)" sureKey:nil];
        return;
    }
    
    [self showHUD];
    
    NSString *strUrl = [NSString stringWithFormat:PARTICPANCE_PINGLUN_URL, self.textView.text, self.topic_id];
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    WS(weakSelf);
    [GentieModel sendPinglunTextWithUrlString:strUrl success:^(NSDictionary *dict) {
        
        [weakSelf hideHUD];
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [WPAlertView showAlertWithMessage:dict[@"msg"] sureKey:^{
                [weakSelf dismissPinglunControllerView:nil];
            }];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [WPAlertView showAlertForNetError];
        [weakSelf hideHUD];
    }];
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
