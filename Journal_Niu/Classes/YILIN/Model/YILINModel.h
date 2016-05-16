//
//  YILINModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/18.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface YILINModel : Model

/*
"adddate" : "2016-04-14 12:07",
"des" : "爱一个已经找到了自己的人，这爱情会更少变数，如果你恰好在他正迷茫，不知自己的时候出现，你多半都会成为他成长的祭祀和牺牲品。",
"icon" : "/upload/1460604812/201604141134576_listthumb_iphone4.jpg",
"id" : "6155",
"title" : "最好的爱情是透过你，我看到自己"
 */

@property (nonatomic, copy) NSString *adddate;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *detail_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *page;

+ (void)getYILINDataWithRrlString:(NSString *)urlString
                          success:(void (^)(NSArray *array))success
                          failure:(void (^)(NSError *error))failure;


@end
