//
//  GentieCell.h
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootTableViewCell.h"

@class GentieModel;
@interface GentieCell : RootTableViewCell

- (void)updateGentieCellWithModel:(GentieModel *)model;

@end
