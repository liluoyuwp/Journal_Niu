//
//  ReadCache+CoreDataProperties.h
//  Journal_Niu
//
//  Created by 黎洛羽 on 16/5/16.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ReadCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReadCache (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *des;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *title;

@end

NS_ASSUME_NONNULL_END
