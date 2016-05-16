//
//  WangqiCache+CoreDataProperties.h
//  Journal_Niu
//
//  Created by 黎洛羽 on 16/5/16.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WangqiCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface WangqiCache (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *count;
@property (nullable, nonatomic, retain) NSString *gentie_id;
@property (nullable, nonatomic, retain) NSString *img;
@property (nullable, nonatomic, retain) NSString *thumb;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *page;

@end

NS_ASSUME_NONNULL_END
