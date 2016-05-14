//
//  LaughCell.h
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootTableViewCell.h"

@class LaughModel;
@interface LaughCell : RootTableViewCell

- (void)updateLaughCellWithModel:(LaughModel *)model;

@end
