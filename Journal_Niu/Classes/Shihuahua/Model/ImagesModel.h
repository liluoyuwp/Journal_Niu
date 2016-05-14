//
//  ImagesModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/22.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface ImagesModel : Model

/*
 "author" : "意林",
 "des" : "《千与千寻》教给我们的九件事",
 "height" : null,
 "icon" : "/upload/1431316439/201505111154044.jpg",
 "id" : "5290",
 "title" : "《千与千寻》教给我们的九件事",
 "width" : null
 */

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *detail_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *width;

+ (void)getImagesDateWithUrlString:(NSString *)urlString
                           success:(void (^)(NSArray *array))success
                           failure:(void (^)(NSError *error))failure;

@end
