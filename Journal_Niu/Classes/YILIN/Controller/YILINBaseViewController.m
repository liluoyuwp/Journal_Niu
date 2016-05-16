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
#import "CoreDataManager.h"

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
    [CoreDataManager shareManager];
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
        
        if (!_isLoadMore) [_arrayDS removeAllObjects];
        
        [weakSelf endRefresh:_isLoadMore];
        [_arrayDS addObjectsFromArray:array];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
        [weakSelf endRefresh:_isLoadMore];
        NSLog(@"%@",error);
    }];
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
        [weakSelf loadNewData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    _page = 0;
    _isLoadMore = NO;
    [self requestData];
}

- (void)loadMoreData {
    _page += 15;
    _isLoadMore = YES;
    [self requestData];
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

@end
