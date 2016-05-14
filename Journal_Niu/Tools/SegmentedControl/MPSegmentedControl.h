/**
 * @file    MPSegmentedControl.h
 * @brief   MPSegmentedControl
 * @author  niu
 * @version 1.0
 * @date    2016-05-10
 */

#import <UIKit/UIKit.h>

@protocol MPSegmentedControlDelegate <NSObject>

/**
 *  @brief the method for button click.
 *
 *  @param index the title index.
 *
 *  @return void nil.
 */
- (void)segBtnClickWithTitleIndex:(NSInteger)index;

@end

@interface MPSegmentedControl : UIView

/// delegate.
@property (nonatomic, assign) id<MPSegmentedControlDelegate>delegate;

/// line color, default is red.
@property (nonatomic, strong) UIColor *lineColor;

/// title color, default is red.
@property (nonatomic, strong) UIColor *titleColor;

/// title place color, default is light gray.
@property (nonatomic, strong) UIColor *titlePlaceColor;

/// the time for moving line, default is 0.2s.
@property (nonatomic ,assign) NSTimeInterval time;

/**
 *  @brief the method for create Seg.
 *
 *  @param titles the array of button title.
 *
 *  @return void nil.
 */
- (void)createSegUIWithTitles:(NSArray *)titles;

@end
