//
//  APIManager.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (void)requestOfGetWithUrl:(NSString *)urlString
                      param:(NSDictionary *)param
                    success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseDict))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
