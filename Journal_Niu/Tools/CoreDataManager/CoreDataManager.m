//
//  CoreDataManager.m
//  Journal_Niu
//
//  Created by WP on 16/5/11.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "CoreDataManager.h"

#import "YiLinCache.h"
#import "YILINModel.h"

#define TABLE_NAME_YILIN @"YiLinCache" //表名

@implementation CoreDataManager

#pragma mark - 系统生成

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "yangyang.niu.coredatafile" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
#pragma mark - 修改1
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyCacheData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
#pragma mark -修改2
    //指定sqlite数据库文件的存储路径(coreData使用的数据库文件后缀一般写sqlite)
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MyCacheData.sqlite"];
    
#pragma mark - 自动迁移
    //为支持自动迁移 传递一个包含2个key的字典作为参数
    NSDictionary * options = @{NSMigratePersistentStoresAutomaticallyOption:[NSNumber numberWithBool:YES],
                                     NSInferMappingModelAutomaticallyOption:[NSNumber numberWithBool:YES]
                               };
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - 我的添加
+ (CoreDataManager *)shareManager {
    static CoreDataManager * manager = nil;
    @synchronized(self){
        if (manager == nil) {
            manager = [[CoreDataManager alloc] init];
        }
    }
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化执行官
        _managedObjectContext = [self managedObjectContext];
    }
    return self;
}

- (void)insertModelToDB:(YILINModel *)model {
    YiLinCache *app = (id)[NSEntityDescription insertNewObjectForEntityForName:TABLE_NAME_YILIN inManagedObjectContext:_managedObjectContext];
    
    //设置需要插入的字段属性
    app.icon = model.icon;
    app.des = model.des;
    app.title = model.title;
    app.page = model.page;
    app.journal_id = model.detail_id;
    app.category = model.category;
    
    NSError * error = nil;
    BOOL success = [_managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }
    
}

- (NSArray *)searchModelInDBWithCategory:(NSString *)category withPage:(NSString *)page {
    //初始化一个查询请求
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    //设置查询的实体
    request.entity = [NSEntityDescription entityForName:TABLE_NAME_YILIN inManagedObjectContext:_managedObjectContext];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"page = %@ and category = %@",page,category];
    request.predicate = predicate;
    
    NSError * error = nil;
    NSArray * arrayResult = [_managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@",[error localizedDescription]];
    }
    return arrayResult;
}


//删
- (void)deleteModel:(YILINModel *)model
{
    //首先需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    //去哪个数据库的哪个表里面找
    [request setEntity:[NSEntityDescription entityForName:TABLE_NAME_YILIN inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext]];
    //查询条件 具体参考官方文档
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"id = %@",model.detail_id];
    [request setPredicate:predicate];
    
    NSError * error = nil;
    NSArray * result = [_managedObjectContext executeFetchRequest:request error:&error];
    
    for (YiLinCache *cache in result) {
        [_managedObjectContext deleteObject:cache];
    }
    
    //保存
    NSError * error2 = nil;
    [_managedObjectContext save:&error2];
    if (error2) {
        [NSException raise:@"删除错误" format:@"%@",[error2 localizedDescription]];
    }
}

//改
- (void)updateModel:(YILINModel *)model
{
    //首先需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    //去哪个数据库的哪个表里面找
    [request setEntity:[NSEntityDescription entityForName:TABLE_NAME_YILIN inManagedObjectContext:[CoreDataManager shareManager].managedObjectContext]];
    //查询条件 具体参考官方文档
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"id = %@",model.detail_id];
    [request setPredicate:predicate];
    
    NSError * error = nil;
    NSArray * result = [_managedObjectContext executeFetchRequest:request error:&error];
    
    for (YiLinCache *cache in result) {
        cache.title = model.title;
    }
    
    //保存
    [self saveContext];
}


@end
