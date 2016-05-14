//
//  YILINCell.h
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootTableViewCell.h"

@class YILINModel;
@interface YILINCell : RootTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (void)updateYilinCellWithModel:(YILINModel *)model;

@end
