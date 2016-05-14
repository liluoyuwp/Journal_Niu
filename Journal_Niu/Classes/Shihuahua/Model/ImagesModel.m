//
//  ImagesModel.m
//  Journal_Niu
//
//  Created by WP on 16/4/22.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "ImagesModel.h"

@implementation ImagesModel

#pragma mark - method
+ (void)getImagesDateWithUrlString:(NSString *)urlString
                           success:(void (^)(NSArray *array))success
                           failure:(void (^)(NSError *error))failure {
    
    [APIManager requestOfGetWithUrl:urlString param:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
        
        NSArray *array = (id)responseDict;
        if (![array isKindOfClass:[NSArray class]]) {
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ImagesModel *model = [[ImagesModel alloc] initWithDictionary:dict];
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
    if ([key isEqualToString:@"id"]) {
        self.detail_id = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
