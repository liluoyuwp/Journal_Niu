//
//  LaughCell.m
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "LaughCell.h"
#import "LaughModel.h"

@interface LaughCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LaughCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.layer.cornerRadius = 3.0;
}

- (void)updateLaughCellWithModel:(LaughModel *)model {
    self.titleLabel.text = [NSString stringWithFormat:@"  %@  ",model.title];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"缺省图"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
