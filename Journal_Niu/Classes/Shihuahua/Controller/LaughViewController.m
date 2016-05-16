//
//  LaughViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "LaughViewController.h"
#import "LaughModel.h"
#import "LaughCell.h"
#import "LaughDetailViewController.h"

@interface LaughViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LaughViewController
{
    NSMutableArray *_arrayDS;
    BOOL _isLoadMore;
    NSInteger _offset;
    CoreDataManager * _cdManager;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
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
    _cdManager = [CoreDataManager shareManager];
}

- (void)initUI {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LaughCell" bundle:nil] forCellReuseIdentifier:@"LaughCell"];
}

- (void)requestData {
    
    WS(weakSelf);
    [LaughModel getLaughDataWithUrlString:[NSString stringWithFormat:KALEIDOSCOPE_LAUGH_URL, _offset] success:^(NSArray *array) {
        
        [weakSelf requestOverWithArray:array];
        [weakSelf insertLaughModelToDB:array];
        
    } failure:^(NSError *error) {
        
        NSArray *array = [_cdManager searchLaughModelInDBWithPage:[NSString stringWithFormat:@"%ld",_offset] type:@"laugh"];
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
        _offset = 0;
        _isLoadMore = NO;
        [weakSelf requestData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _offset += 10;
        _isLoadMore = YES;
        [weakSelf requestData];
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *laughCellID = @"LaughCell";
    LaughCell *cell = [tableView dequeueReusableCellWithIdentifier:laughCellID forIndexPath:indexPath];
    [cell updateLaughCellWithModel:_arrayDS[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LaughModel *model = _arrayDS[indexPath.row];
    CGFloat width = [model.width floatValue];
    CGFloat height = [model.height floatValue];
    CGFloat cellH = [self getLaughCellHeightWithW:width H:height];
    return cellH;
}

- (CGFloat)getLaughCellHeightWithW:(CGFloat)width H:(CGFloat)height {

    height = height / (width / SCREEN_WIDTH);
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LaughDetailViewController *laughDetailVC = (id)[self initViewControllerWithStoryBoardID:@"laughdetail"];
    LaughModel *model = _arrayDS[indexPath.row];
    laughDetailVC.detail_id = model.gid;
    [self.navigationController pushViewController:laughDetailVC animated:NO];
}


#pragma mark - Method
- (void)insertLaughModelToDB:(NSArray *)array {
    [_cdManager deleteLaughModelWithWithPage:[NSString stringWithFormat:@"%ld",_offset] type:@"laugh"];
    for (LaughModel *model in array) {
        model.page = [NSString stringWithFormat:@"%ld",_offset];
        model.type = @"laugh";
        [_cdManager insertLaughModelInDB:model];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
