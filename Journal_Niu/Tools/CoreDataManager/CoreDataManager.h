//
//  CoreDataManager.h
//  Journal_Niu
//
//  Created by WP on 16/5/11.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class YILINModel;
@class LaughModel;
@class ReadModel;
@class WangqiModel;
@class GentieModel;

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


//YiLin
/// yilin模块-增.
- (void)insertYilinModelInDB:(YILINModel *)model;

/// yilin模块-查.
- (NSArray *)searchYilinModelInDBWithType:(NSString *)type
                                 withPage:(NSString *)page;

/// yilin模块-删
- (void)deleteYilinModelWithType:(NSString *)type
                        withPage:(NSString *)page;

//搞笑秀
/// 搞笑秀-增
- (void)insertLaughModelInDB:(LaughModel *)model;

/// 搞笑秀-查
- (NSArray *)searchLaughModelInDBWithPage:(NSString *)page
                                     type:(NSString *)type;

/// 搞笑秀-删
- (void)deleteLaughModelWithWithPage:(NSString *)page
                                type:(NSString *)type;

//搞笑秀
/// 微阅读-增
- (void)insertReadModelInDB:(ReadModel *)model;

/// 微阅读-查
- (NSArray *)searchReadModelInDB;

/// 微阅读-删
- (void)deleteReadModelInDB;

//指谈会
/// 往期-增
- (void)insertWangqiModelInDB:(WangqiModel *)model;

/// 往期-查
- (NSArray *)searchWangqiModelInDBWithPage:(NSString *)page
                                      type:(NSString *)type;

/// 往期-删
- (void)deleteWangqiModelWithWithPage:(NSString *)page
                                 type:(NSString *)type;

//指谈会
/// 跟帖-增
- (void)insertGentieModelInDB:(GentieModel *)model;

/// 跟帖-查
- (NSArray *)searchGentieModelInDBWithPage:(NSString *)page
                                 gentie_id:(NSString *)gentie_id
                                      type:(NSString *)type;

/// 跟帖-删
- (void)deleteGentieModelWithWithPage:(NSString *)page
                            gentie_id:(NSString *)gentie_id
                                 type:(NSString *)type;

@end
