//
//  WangqiViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "WangqiViewController.h"
#import "WangqiModel.h"
#import "WangqiCell.h"
#import "GentieViewController.h"

@interface WangqiViewController ()<UITableViewDelegate,UITableViewDataSource,WangqiCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WangqiViewController
{
    NSMutableArray *_arrayDS;
    BOOL _isLoadMore;
    NSInteger _offset;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
    
    [self requestData];
    
    [self addRefreshAndLoadMore];
}

- (void)initData {
    _arrayDS = [NSMutableArray array];
    _isLoadMore = NO;
    _offset = 0;
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"WangqiCell" bundle:nil] forCellReuseIdentifier:@"WangqiCell"];
}

- (void)requestData {
    
    WS(weakSelf);
    [WangqiModel getWangqiListDataWithUrlString:[NSString stringWithFormat:PARTICPANCE_TALK_WHAT_URL, _offset] success:^(NSArray *array) {
        
        [weakSelf requestOverWithArray:array];
        [weakSelf insertWangqiModelToDB:array];

    } failure:^(NSError *error) {
        
        NSArray *array = [weakSelf.cdManager searchWangqiModelInDBWithPage:[NSString stringWithFormat:@"%ld",_offset] type:@"list"];
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
        [weakSelf loadNewData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    _offset = 0;
    _isLoadMore = NO;
    [self requestData];
}

- (void)loadMoreData {
    _offset += 15;
    _isLoadMore = YES;
    [self requestData];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *wangqiCellID = @"WangqiCell";
    WangqiCell *cell = [tableView dequeueReusableCellWithIdentifier:wangqiCellID forIndexPath:indexPath];
    cell.delegate = self;
    [cell updateWangqiCellWithModel:_arrayDS[indexPath.row]];
    return cell;
}

#pragma mark - WangqiCellDelegate
- (void)pushToGentieVCWithId:(NSString *)wangqi_id title:(NSString *)title {
    
    GentieViewController *vc = (id)[self initViewControllerWithStoryBoardID:@"gentie"];
    vc.gentie_id = wangqi_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Method
- (void)insertWangqiModelToDB:(NSArray *)array {
    [self.cdManager deleteWangqiModelWithWithPage:[NSString stringWithFormat:@"%ld",_offset] type:@"list"];
    for (WangqiModel *model in array) {
        model.page = [NSString stringWithFormat:@"%ld",_offset];
        model.type = @"list";
        [self.cdManager insertWangqiModelInDB:model];
    }
}

@end
