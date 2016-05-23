//
//  LaughModel.m
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "LaughModel.h"

@implementation LaughModel

#pragma mark - method
+ (void)getLaughDataWithUrlString:(NSString *)urlString
                          success:(void (^)(NSArray *array))success
                          failure:(void (^)(NSError *error))failure {
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSArray *array = responseDict[@"list"];
        if (![array isKindOfClass:[NSArray class]]) {
            
            if (failure) failure(nil);
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            LaughModel *model = [[LaughModel alloc] initWithDictionary:dict];
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
    if ([key isEqualToString:@"icon"]) {
        self.icon = [NSString stringWithFormat:@"%@%@",YILIN_ICON_URL,value];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
