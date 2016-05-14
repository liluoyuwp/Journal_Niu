//
//  GentieCell.m
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "GentieCell.h"
#import "GentieModel.h"

@interface GentieCell ()

@property (weak, nonatomic) IBOutlet UILabel *memberInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation GentieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateGentieCellWithModel:(GentieModel *)model {
    self.memberInfoLabel.text = [NSString stringWithFormat:@"%@(%@)说:",model.name,model.adddate];
    self.countLabel.text = [NSString stringWithFormat:@"顶贴数:%@",model.up_times];
    self.contentLabel.text = model.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
