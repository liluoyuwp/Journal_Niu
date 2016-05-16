//
//  YILINBaseViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/19.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "YILINBaseViewController.h"
#import "YILINCell.h"
#import "YILINModel.h"
#import "YiLinDetailViewController.h"

@interface YILINBaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation YILINBaseViewController
{
    UITableView *_tableView;
    NSMutableArray *_arrayDS;
    BOOL _isLoadMore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
    [self requestData];
    [self addRefreshAndLoadMore];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)initData {
    _arrayDS = [NSMutableArray array];
    _page = 0;
    _isLoadMore = NO;
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - 20, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"YILINCell" bundle:nil] forCellReuseIdentifier:@"YILINCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)requestData {
    
    WS(weakSelf);
    [YILINModel getYILINDataWithRrlString:[self getRequestUrl] success:^(NSArray *array) {
        
        [weakSelf requestOverWithArray:array];
        [weakSelf insertYilinModelToDB:array];
    } failure:^(NSError *error) {
        
        NSArray *array = [weakSelf.cdManager searchYilinModelInDBWithType:_type withPage:[NSString stringWithFormat:@"%ld",_page]];
        [weakSelf requestOverWithArray:array];
        NSLog(@"%@\n\n\n请求失败时读取缓存:%ld",error,array.count);
    }];
}

- (void)requestOverWithArray:(NSArray *)array {
    if (!_isLoadMore) [_arrayDS removeAllObjects];
    
    [_arrayDS addObjectsFromArray:array];
    [_tableView reloadData];
    [self endRefresh:_isLoadMore];
}

- (void)endRefresh:(BOOL)isLoadMore {
    if (isLoadMore) {
        [_tableView.mj_footer endRefreshing];
    } else {
        [_tableView.mj_header endRefreshing];
    }
}

- (void)addRefreshAndLoadMore {
    WS(weakSelf);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        _isLoadMore = NO;
        [weakSelf requestData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page += 15;
        _isLoadMore = YES;
        [weakSelf requestData];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"YILINCell";
    YILINCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell updateYilinCellWithModel:_arrayDS[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 87.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YILINCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    YILINModel *model = _arrayDS[indexPath.row];
    
    YiLinDetailViewController *vc = (id)[self initViewControllerWithStoryBoardID:@"yilindetail"];
    vc.yiLinDetail_id = model.detail_id;
    vc.text = model.title;
    vc.image = cell.iconImageView.image;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Method
- (NSString *)getRequestUrl {
    return nil;
}

- (void)insertYilinModelToDB:(NSArray *)array {
    [self.cdManager deleteYilinModelWithType:_type withPage:[NSString stringWithFormat:@"%ld",_page]];
    for (YILINModel *model in array) {
        model.type = _type;
        model.page = [NSString stringWithFormat:@"%ld",_page];
        [self.cdManager insertYilinModelInDB:model];
    }
}

@end
