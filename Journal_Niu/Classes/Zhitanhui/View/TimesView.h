//
//  TimesView.h
//  Journal_Niu
//
//  Created by WP on 16/5/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GentieModel;

@protocol TimesViewDelegate <NSObject>

- (void)buttonClickTithTag:(NSInteger)tag
                     model:(GentieModel *)model
                    finish:(void (^) ())finish;

@end

@interface TimesView : UIView

+ (void)showTimesViewWithView:(UIView *)view
                     delegate:(id)delegate
                        Frame:(CGRect)frame
                         info:(GentieModel *)model;

@end
