/**
 * @file    WPAlertView.h
 * @brief   WPAlertView
 * @author  niu
 * @version 1.0
 * @date    2016-02-22
 */

#import <Foundation/Foundation.h>

@interface WPAlertView : NSObject

/**
 *  @brief show alertView when net error.
 *
 *  @param nil.
 *
 *  @return void nil.
 */
+ (void)showAlertForNetError;

/**
 *  @brief show alertView when Parameter error.
 *
 *  @param nil.
 *
 *  @return void nil.
 */
+ (void)showAlertForParameterError;

/**
 *  @brief only sureButton.
 *
 *  @param message the message for alertView.
 *
 *  @param surekey the block for sure button in alertview.
 *
 *  @return void nil.
 */
+ (void)showAlertWithMessage:(NSString *)message
                     sureKey:(void(^) ())surekey;

/**
 *  @brief only sureButton.
 *
 *  @param title the title for alertView.
 *
 *  @param message the message for alertView.
 *
 *  @param surekey the block for sure button in alertview, when clicked, it will be executed.
 *
 *  @return void nil.
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   sureKey:(void(^) ())surekey;

/**
 *  @brief sureButton and cancel button.
 *
 *  @param message the message for alertView.
 *
 *  @param surekey the block for sure button in alertview, when clicked, it will be executed.
 *
 *  @param cancelKey the block for cancel button in alertview, when clicked, it will be executed.
 *
 *  @return void nil.
 */
+ (void)showAlertWithMessage:(NSString *)message
                     sureKey:(void(^) ())surekey
                   cancelKey:(void(^) ())cancelKey;

/**
 *  @brief sureButton and cancel button.
 *
 *  @param title the title for alertView.
 *
 *  @param message the message for alertView.
 *
 *  @param surekey the block for sure button in alertview, when clicked, it will be executed.
 *
 *  @param cancelKey the block for cancel button in alertview, when clicked, it will be executed.
 *
 *  @return void nil.
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                   sureKey:(void(^) ())surekey
                 cancelKey:(void(^) ())cancelKey;

/**
 *  @brief DIY cancelKeyTitle(left) rightKeyTitle(right).
 *
 *  @param title the title for alertView.
 *
 *  @param message the message for alertView.
 *
 *  @param cancelKeyTitle the title for left button in alertView.
 *
 *  @param rightKeyTitle the title for right button in alertView.
 *
 *  @param surekey the block for right button in alertview, when clicked, it will be executed.
 *
 *  @param cancelKey the block for cancel button in alertview, when clicked, it will be executed.
 *
 *  @return void nil.
 */
+ (void)showAlertWithTitle:(NSString*)title
                   message:(NSString *)message
            cancelKeyTitle:(NSString *)cancelKeyTitle
             rightKeyTitle:(NSString *)rightKeyTitle
                  rightKey:(void(^) ())rightKey
                 cancelKey:(void(^) ())cancelkey;

/**
 *  @brief auto dismiss.
 *
 *  @param message the message for alertview.
 *
 *  @param delay the time for the alertView to disappear.
 *
 *  @return void nil.
 */
+ (void)showAlertWithMessage:(NSString *)message
     autoDisappearAfterDelay:(NSTimeInterval)delay;

@end
