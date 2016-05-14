//
//  WangqiModel.m
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "WangqiModel.h"

@implementation WangqiModel

#pragma mark - methods
+ (void)getWangqiDataWithUrlString:(NSString *)urlString
                           success:(void (^)(WangqiModel *model))success
                           failure:(void (^)(NSError *error))failure {
    
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSArray *array = responseDict[@"list"];
        if (!(array && [array isKindOfClass:[NSArray class]])) {
            return ;
        }
        
        WangqiModel *model;
        if (array.count > 0) {
            NSDictionary *dict = array[0];
            model  = [[WangqiModel alloc] initWithDictionary:dict];
        }
        
        if (success) {
            success(model);
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)getWangqiListDataWithUrlString:(NSString *)urlString
                               success:(void (^)(NSArray * array))success
                               failure:(void (^)(NSError *error))failure {
    
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSArray *array = responseDict[@"list"];
        if (![array isKindOfClass:[NSArray class]]) {
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            WangqiModel *model = [[WangqiModel alloc] initWithDictionary:dict];
            [arr addObject:model];
        }
        
        if (success) {
            success([arr copy]);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"img"]) {
        self.img = [NSString stringWithFormat:@"%@%@",YILIN_ICON_URL,value];
    } else if ([key isEqualToString:@"thumb"]) {
        self.thumb = [NSString stringWithFormat:@"%@%@",YILIN_ICON_URL,value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.gentie_id = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
