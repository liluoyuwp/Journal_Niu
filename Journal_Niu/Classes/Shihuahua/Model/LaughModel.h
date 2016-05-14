//
//  LaughModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface LaughModel : Model

/*
"gid" : "5710",
"height" : 849,
"icon" : "/upload/1445853457/201510261758297.jpg",
"title" : "我要怎么收拾他？",
"width" : 572
*/

@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *width;

+ (void)getLaughDataWithUrlString:(NSString *)urlString
                          success:(void (^)(NSArray *array))success
                          failure:(void (^)(NSError *error))failure;

@end
