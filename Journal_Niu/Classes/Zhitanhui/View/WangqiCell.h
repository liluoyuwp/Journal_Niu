//
//  WangqiCell.h
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootTableViewCell.h"

@protocol WangqiCellDelegate <NSObject>

- (void)pushToGentieVCWithId:(NSString *)wangqi_id
                       title:(NSString *)title;

@end

@class WangqiModel;
@interface WangqiCell : RootTableViewCell

@property (nonatomic, assign) id<WangqiCellDelegate>delegate;

- (void)updateWangqiCellWithModel:(WangqiModel *)model;

@end
