//
//  TimesView.h
//  Journal_Niu
//
//  Created by WP on 16/5/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimesViewDelegate <NSObject>

- (void)buttonClickTithTag:(NSInteger)tag
                   finish:(void (^) (BOOL success))finish;

@end

@interface TimesView : UIView

@property (nonatomic, assign) id<TimesViewDelegate>delegate;

@end
