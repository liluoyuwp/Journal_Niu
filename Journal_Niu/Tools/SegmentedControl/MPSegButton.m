/**
 * @file    MPSegButton.m
 * @brief   MPSegButton
 * @author  niu
 * @version 1.0
 * @date    2016-05-10
 */

#import "MPSegButton.h"

@implementation MPSegButton

+ (instancetype)createSegButtonWithTitle:(NSString *)title
                              titleColor:(UIColor *)titleColor
                         titlePlaceColor:(UIColor *)titlePlaceColor
                                   frame:(CGRect)frame
                                  target:(id)target
                                  action:(SEL)action
                               buttonTag:(NSInteger)tag {
    
    MPSegButton *button = [MPSegButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateSelected];
    [button setTitleColor:titlePlaceColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    button.buttonTag = tag;
    return button;
}

@end
