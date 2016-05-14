//
//  APIManager.m
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "Config.h"

@implementation APIManager

+ (void)requestOfGetWithUrl:(NSString *)urlString
                      param:(NSDictionary *)param
                    success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseDict))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSLog(@"请求的URL:%@",urlString);
    [[self shareAFManager] GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(task,dict);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task,error);
        }
    }];
}

+ (AFHTTPSessionManager *)shareAFManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = REQUEST_TIME;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    return manager;
}

@end
