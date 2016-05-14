//
//  ReadModel.h
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "Model.h"

@interface ReadModel : Model

/*
 "adddate" : "2012-09-28 11:16",
 "des" : " 张爱玲写了篇小说，叫《爱》。她像个催眠师一样，把我们大家对爱情的憧憬都唤醒了：于千万人之中，遇见你所要遇见的人，于千万年之中，时间的无涯的荒野里，没有早一步，也没有晚一步，刚巧赶上了，没有别的话可说，唯有轻轻地问一声：“噢，你也在这里？”\r\n 这感觉很缥缈，很浮云，暖暖的，甜甜的。人人都愿意为之一试，哪怕伤痕累累。但是，问世间情为何物，直教人生死相许？对此，可能每个人都有自己见仁见智的答案。\r\n爱情像什么？顾城说，爱情像钓鱼。他在《分别的海》里说：“我没带渔具，没带沉重的疑虑和枪；我想，到空旷的海上，只要说爱你，鱼群就会跟着我，游向陆地。”\r\n 如果爱情真这么简单，世界就安静了。有一个很简单的爱情定律，叫“在对的时间，遇见对的人”，让很多人苦恼不已，因为人在江湖，总是身不由己。",
 "icon" : "/upload/1348802209/201209281117159_header_iphone4.jpg",
 "id" : "716",
 "title" : "如果所有的玫瑰都凋谢在你身旁"
 */
@property (nonatomic, copy) NSString *adddate;
@property (nonatomic, copy) NSString *des;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *des_id;
@property (nonatomic, copy) NSString *title;

+ (void)getReadDataWithUrlString:(NSString *)urlString
                         success:(void (^)(NSArray *array))success
                         failure:(void (^)(NSError *error))failure;

@end
