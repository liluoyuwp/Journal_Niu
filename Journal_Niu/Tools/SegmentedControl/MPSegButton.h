/**
 * @file    MPSegButton.h
 * @brief   MPSegButton
 * @author  niu
 * @version 1.0
 * @date    2016-05-10
 */

#import <UIKit/UIKit.h>

@interface MPSegButton : UIButton

/// button tag.
@property (nonatomic, assign) NSInteger buttonTag;

/**
 *  @brief create seg button.
 *
 *  @param title button title.
 *
 *  @param titleColor button title color.
 *
 *  @param titlePlaceColor button title place color.
 *
 *  @param frame button frame.
 *
 *  @param target the button target.
 *
 *  @param action the target action.
 *
 *  @param tag the button tag.
 *
 *  @return instancetype button.
 */
+ (instancetype)createSegButtonWithTitle:(NSString *)title
                              titleColor:(UIColor *)titleColor
                         titlePlaceColor:(UIColor *)titlePlaceColor
                                   frame:(CGRect)frame
                                  target:(id)target
                                  action:(SEL)action
                               buttonTag:(NSInteger)tag;

@end
