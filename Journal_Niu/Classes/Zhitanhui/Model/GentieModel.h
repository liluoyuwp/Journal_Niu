//
//  GentieModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface GentieModel : Model

/*
 "adddate" : "15:08 01-10",
 "content" : "说点什么吧...zhen",
 "down_times" : "0",
 "name" : "",
 "uid" : "137840",
 "up_times" : "0"
 */
@property (nonatomic, copy) NSString *adddate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *down_times;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *up_times;

+ (void)getGentieDataWithUrlString:(NSString *)urlString
                           success:(void (^)(NSArray *array))success
                           failure:(void (^)(NSError *error))failure;

+ (void)sendPinglunTextWithUrlString:(NSString *)urlString
                             success:(void (^)(NSDictionary *dict))success
                             failure:(void (^)(NSError *error))failure;

@end
