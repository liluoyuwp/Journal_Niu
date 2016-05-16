//
//  WangqiModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface WangqiModel : Model

/*
"content" : "武汉姑娘袁莉说起在婆家的过年经历，显得“义愤填膺”。“过年时天天都有客人来拜年，家里的男人们就统统上桌吃饭，女人们就都下厨做饭，不管是新媳妇还是老母亲，只能在厨房支个小桌随便吃点，或者吃大桌剩下的饭菜。” 你怎么看？",
"count" : "312",
"id" : "5051",
"img" : "/upload/1425006201/201502271103443.jpg",
"thumb" : "/upload/1425006201/201502271103443_thumb_iphone4.jpg",
"title" : "女人不能上席遭吐槽 你们那有这规矩吗？"
 */

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *gentie_id;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *page;

+ (void)getWangqiDataWithUrlString:(NSString *)urlString
                           success:(void (^)(WangqiModel *model))success
                           failure:(void (^)(NSError *error))failure;

+ (void)getWangqiListDataWithUrlString:(NSString *)urlString
                               success:(void (^)(NSArray * array))success
                               failure:(void (^)(NSError *error))failure;

@end
