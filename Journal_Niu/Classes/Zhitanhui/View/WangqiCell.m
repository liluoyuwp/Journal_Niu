//
//  WangqiCell.m
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "WangqiCell.h"
#import "WangqiModel.h"

@interface WangqiCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *gentieButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation WangqiCell
{
    WangqiModel *_model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.lineView.layer.shadowRadius = 1;
    self.lineView.layer.shadowOpacity = 0.5;
    self.lineView.layer.shadowOffset = CGSizeMake(1, 1);
}

- (void)updateWangqiCellWithModel:(WangqiModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"缺省图"]];
    self.contentLabel.text = model.content;
    [self.gentieButton setTitle:[NSString stringWithFormat:@"跟帖      %@",model.count] forState:UIControlStateNormal];
}

- (IBAction)wangqi:(id)sender {
    if ([self.delegate respondsToSelector:@selector(pushToGentieVCWithId:title:)]) {
        [self.delegate pushToGentieVCWithId:_model.gentie_id title:_model.title];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
