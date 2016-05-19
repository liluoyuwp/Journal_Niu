//
//  GentieModel.m
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "GentieModel.h"
#import "YLAPI.h"

@implementation GentieModel

#pragma mark - method
+ (void)getGentieDataWithUrlString:(NSString *)urlString
                           success:(void (^)(NSArray *array))success
                           failure:(void (^)(NSError *error))failure {
    
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSArray *array = responseDict[@"list"];
        if (![array isKindOfClass:[NSArray class]]) {
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            GentieModel *model = [[GentieModel alloc] initWithDictionary:dict];
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

+ (void)sendPinglunTextWithUrlString:(NSString *)urlString
                             success:(void (^)(NSDictionary *dict))success
                             failure:(void (^)(NSError *error))failure {
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        if (responseDict.allKeys.count >= 2) {
            if (success) {
                success(responseDict);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)requestForTimesWithGentieID:(NSString *)gentie_id
                          isUptimes:(BOOL)isUptimes
                           complete:(void (^) (BOOL isUptimes))complete {
    
    NSString *urlString = nil;
    if (isUptimes) {
        urlString = [NSString stringWithFormat:PARTICPANCE_COMMENTLIST_UPTIMES,gentie_id];
    } else {
        urlString = [NSString stringWithFormat:PARTICPANCE_COMMENTLIST_DOWNTIMES, gentie_id];
    }
    
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        if (complete) {
            complete(isUptimes);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - KVC
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if (self.name.length == 0) {
        self.name = @"意林网友";
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
