//
//  GentieViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/20.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "GentieViewController.h"
#import "GentieModel.h"
#import "GentieCell.h"
#import "MPSegmentedControl.h"

@interface GentieViewController ()<UITableViewDelegate,UITableViewDataSource,MPSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GentieViewController
{
    NSMutableArray *_arrayDS;
    BOOL _isLoadMore;
    NSInteger _offset;
    NSString *_urlString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self initUI];
    
    [self showHUD];
    
    [self requestData];
    
    [self addRefreshAndLoadMore];
}

- (void)initData {
    _arrayDS = [NSMutableArray array];
    _isLoadMore = NO;
    _offset = 0;
    _urlString = PARTICPANCE_COMMENTLIST_URL;
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    
    MPSegmentedControl *seg = [[MPSegmentedControl alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 44)];
    seg.delegate = self;
    [seg createSegUIWithTitles:@[@"按顶贴数排序",@"按时间排序"]];
    [self.view addSubview:seg];
    
    self.tableView.estimatedRowHeight = 30;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GentieCell" bundle:nil] forCellReuseIdentifier:@"GentieCell"];
}

- (void)requestData {
    WS(weakSelf);
    [GentieModel getGentieDataWithUrlString:[NSString stringWithFormat:_urlString,self.gentie_id,_offset] success:^(NSArray *array) {
        
        if (!_isLoadMore) [_arrayDS removeAllObjects];
        
        [weakSelf endRefresh:_isLoadMore];
        [_arrayDS addObjectsFromArray:array];
        [_tableView reloadData];
        
        [weakSelf hideHUD];
        
    } failure:^(NSError *error) {
        
        [weakSelf hideHUD];
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
    static NSString *gentieCellID = @"GentieCell";
    GentieCell *cell = [tableView dequeueReusableCellWithIdentifier:gentieCellID forIndexPath:indexPath];
    [cell updateGentieCellWithModel:_arrayDS[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MPSegmentedControlDelegate
- (void)segBtnClickWithTitleIndex:(NSInteger)index {
    if (index == 0) {
        _urlString = PARTICPANCE_COMMENTLIST_URL;
    } else {
        _urlString = PARTICPANCE_COMMENTLIST_TIME_URL;
    }
    _offset = 0;
    _isLoadMore = NO;
    [self requestData];
    [self showHUD];
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
