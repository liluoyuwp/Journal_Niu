//
//  TimesView.m
//  Journal_Niu
//
//  Created by WP on 16/5/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "TimesView.h"
#import "Config.h"
#import "GentieModel.h"

@interface TimesView ()

@property (weak, nonatomic) IBOutlet UILabel *uptimesStatus;
@property (weak, nonatomic) IBOutlet UILabel *downtimesStatus;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *uptimesBtn;
@property (weak, nonatomic) IBOutlet UIButton *downtimesBtn;

@property (weak, nonatomic) IBOutlet UIImageView *closeView;

@property (nonatomic, assign) id<TimesViewDelegate>delegate;

@end

@implementation TimesView
{
    GentieModel *_model;
    UIView *_bgView;
    NSInteger _uptimes;
    NSInteger _downtimes;
}

- (void)awakeFromNib {
    
    self.uptimesStatus.clipsToBounds = YES;
    self.uptimesStatus.layer.cornerRadius = 9.0f;
    self.downtimesStatus.clipsToBounds = YES;
    self.downtimesStatus.layer.cornerRadius = 9.0f;
    
    [self.closeView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                          action:@selector(removeBackgroundView)]];
}

#pragma mark - btn action
- (IBAction)btnAction:(UIButton *)sender {
    
    sender.enabled = NO;
    [self viewWithTag:sender.tag + 2].hidden = NO;;
    WS(weakSelf);
    if ([self.delegate respondsToSelector:@selector(buttonClickTithTag:model:finish:)]) {
        
        [self.delegate buttonClickTithTag:sender.tag model:_model finish:^() {
            sender.enabled = YES;
            
            NSString *title = nil;
            if (sender.tag == 555) {
                
                title = [NSString stringWithFormat:@"顶贴      %ld",++_uptimes] ;
            } else {
                
                title = [NSString stringWithFormat:@"倒贴      %ld",++_downtimes];
            }
            [weakSelf setAttributedTitleWithBtn:sender title:title];
            
            [weakSelf performSelector:@selector(hideStatus:) withObject:@(sender.tag + 2) afterDelay:0.5];
        }];
    }
}

- (void)hideStatus:(id)tag {
    
    if (![self viewWithTag:[tag integerValue]].hidden) {
        
        [self viewWithTag:[tag integerValue]].hidden = YES;
    }
}

#pragma mark - public methods
+ (void)showTimesViewWithView:(UIView *)view
                     delegate:(id)delegate
                        Frame:(CGRect)frame
                         info:(GentieModel *)model {
    
    TimesView *timeView = [[[NSBundle mainBundle] loadNibNamed:@"TimesView" owner:self options:nil] lastObject];
    timeView.frame = CGRectMake(frame.origin.x + CGRectGetWidth(frame)/2.0, frame.origin.y + CGRectGetHeight(frame)/2.0, 0, 0);
    timeView.delegate = delegate;
    
    [timeView getBackGroundView:view
                          frame:(CGRect)frame
                       selfView:timeView
                          model:model];
}

#pragma mark - methods
- (void)getBackGroundView:(UIView *)view
                    frame:(CGRect)frame
                 selfView:(UIView *)selfView
                    model:(GentieModel *)model {
    
    _bgView = [[UIView alloc] initWithFrame:view.frame];
    _bgView.backgroundColor = [UIColor clearColor];
    [view addSubview:_bgView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:view.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [_bgView addSubview:bgView];
        
    selfView.clipsToBounds = YES;
    selfView.layer.cornerRadius = 4.5f;
    [_bgView addSubview:selfView];
    
    [self updateInfoWith:model];
    
    // 动画显示view
    [UIView animateWithDuration:0.5 animations:^{
        selfView.frame = frame;
    }];
}

- (void)updateInfoWith:(GentieModel *)model {
    _model = model;
    _uptimes = [model.up_times integerValue];
    _downtimes = [model.down_times integerValue];
    
    self.infoLabel.text = [NSString stringWithFormat:@"%@(%@)说:",model.name,model.adddate];
    self.contentLabel.text = model.content;
    [self setAttributedTitleWithBtn:self.uptimesBtn title:[NSString stringWithFormat:@"顶贴      %@",model.up_times]];
    [self setAttributedTitleWithBtn:self.downtimesBtn title:[NSString stringWithFormat:@"倒贴      %@",model.down_times]];
}

- (void)setAttributedTitleWithBtn:(UIButton *)btn title:(NSString *)title {

    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString: title];
    [attribute addAttributes: @{NSForegroundColorAttributeName: [UIColor colorWithRed:13/255.0 green:148/255.0 blue:252/255.0 alpha:1]} range: NSMakeRange(0, 2)];
    [attribute addAttributes: @{NSForegroundColorAttributeName: [UIColor lightGrayColor]} range: NSMakeRange(2, title.length - 2)];
    [btn setAttributedTitle:attribute forState:UIControlStateNormal];
}

#pragma mark - Tap Method
- (void)removeBackgroundView {
    [_bgView removeFromSuperview];
}

@end
