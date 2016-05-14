//
//  YILINBaseViewController.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootViewController.h"

@interface YILINBaseViewController : RootViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) NSInteger page;

- (NSString *)getRequestUrl;

@end
