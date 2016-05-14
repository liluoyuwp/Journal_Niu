//
//  CoreDataManager.h
//  Journal_Niu
//
//  Created by WP on 16/5/11.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject

#pragma mark - 系统生成
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//对象模型管理属性 作用 : 操作 Person.xcdatamodeld DSZ
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//链接属性 作用 : 实现 Person.xcdatamodeld 和 沙盒目录下得真正的数据库文件的链接过程 Secretary
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存 相当于数据库的关闭数据库操作
- (void)saveContext;

//获得沙盒Documents路径
- (NSURL *)applicationDocumentsDirectory;


#pragma mark- 我的添加
// 单例管理类对象
+ (CoreDataManager *)shareManager;

@end
