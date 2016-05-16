//
//  YiLinCache+CoreDataProperties.h
//  Journal_Niu
//
//  Created by WP on 16/5/16.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "YiLinCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface YiLinCache (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *journal_id;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *page;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *des;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
