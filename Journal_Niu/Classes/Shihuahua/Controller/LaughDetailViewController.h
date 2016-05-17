//
//  LaughDetailViewController.h
//  Journal_Niu
//
//  Created by WP on 16/4/22.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "RootViewController.h"

@class LaughModel;

@interface LaughDetailViewController : RootViewController

@property (nonatomic, copy) NSString *detail_id;

@property (nonatomic, strong) LaughModel *shoucang_model;

@end
