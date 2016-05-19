//
//  TimesView.m
//  Journal_Niu
//
//  Created by WP on 16/5/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "TimesView.h"
#import "Config.h"

@interface TimesView ()

@property (weak, nonatomic) IBOutlet UILabel *uptimesStatus;
@property (weak, nonatomic) IBOutlet UILabel *downtimesStatus;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *uptimesBtn;
@property (weak, nonatomic) IBOutlet UIButton *downtimesBtn;

@end

@implementation TimesView

- (void)awakeFromNib {
    
    self.uptimesStatus.clipsToBounds = YES;
    self.uptimesStatus.layer.cornerRadius = 9.0f;
    self.downtimesStatus.clipsToBounds = YES;
    self.downtimesStatus.layer.cornerRadius = 9.0f;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    sender.enabled = NO;
    [self viewWithTag:sender.tag + 2].hidden = NO;;
    WS(weakSelf);
    if ([self.delegate respondsToSelector:@selector(buttonClickTithTag:finish:)]) {
        
        [self.delegate buttonClickTithTag:sender.tag finish:^(BOOL success) {
            sender.enabled = YES;
            if (success) {
                [weakSelf performSelector:@selector(hideStatus:) withObject:@(sender.tag + 2) afterDelay:0.5];
            }
        }];
    }
}

- (void)hideStatus:(id)tag {
    
    if (![self viewWithTag:[tag integerValue]].hidden) {
        
        [self viewWithTag:[tag integerValue]].hidden = YES;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
