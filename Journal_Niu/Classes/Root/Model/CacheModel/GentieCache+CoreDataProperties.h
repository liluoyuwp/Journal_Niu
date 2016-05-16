//
//  GentieCache+CoreDataProperties.h
//  Journal_Niu
//
//  Created by 黎洛羽 on 16/5/16.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GentieCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface GentieCache (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *adddate;
@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSString *up_times;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *page;
@property (nullable, nonatomic, retain) NSString *gentie_id;
@property (nullable, nonatomic, retain) NSString *type;

@end

NS_ASSUME_NONNULL_END
