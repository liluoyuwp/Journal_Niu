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
#import "PinglunViewController.h"
#import "TimesView.h"

@interface GentieViewController ()<
UITableViewDelegate,
UITableViewDataSource,
MPSegmentedControlDelegate,
TimesViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GentieViewController
{
    NSMutableArray *_arrayDS;
    BOOL _isLoadMore;
    NSInteger _offset;
    NSString *_urlString;
    NSString *_type;
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
    _type = @"count";
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
        
        [weakSelf requestOverWithArray:array];
        [weakSelf insertGentieModelToDB:array];


    } failure:^(NSError *error) {
        
        NSArray *array = [weakSelf.cdManager searchGentieModelInDBWithPage:[NSString stringWithFormat:@"%ld",_offset]
                                                                 gentie_id:_gentie_id
                                                                      type:_type];
        [weakSelf requestOverWithArray:array];
        NSLog(@"%@\n\n\n请求失败时读取缓存:%ld",error,array.count);
    }];
}

- (void)requestOverWithArray:(NSArray *)array {
    if (!_isLoadMore) [_arrayDS removeAllObjects];
    
    [_arrayDS addObjectsFromArray:array];
    [_tableView reloadData];
    [self hideHUD];
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
        _offset += 15;
        _isLoadMore = YES;
        [weakSelf requestData];
    }];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    GentieModel *model = _arrayDS[indexPath.row];
    
    CGSize size = [model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20 - 16, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil].size;
    
    CGFloat height = size.height;
    if (height > 300) {
        height = 300;
    }
    CGRect rect = CGRectMake(10, SCREEN_HEIGHT/2.0 - (size.height + 82)/2.0 - 10, SCREEN_WIDTH - 20, height + 82);

    
    [TimesView showTimesViewWithView:self.tabBarController.view
                            delegate:self
                               Frame:rect
                                info:model];
    }

#pragma mark - TimesViewDelegate
- (void)buttonClickTithTag:(NSInteger)tag
                  model:(GentieModel *)model
                    finish:(void (^) ())finish {
    
    BOOL isUptimes = NO;
    if (tag == 555) isUptimes = YES;
    
    [GentieModel requestForTimesWithGentieID:model.uid isUptimes:isUptimes complete:^(BOOL isUptimes) {
        
        if (isUptimes) {
            model.up_times  = [NSString stringWithFormat:@"%ld",[model.up_times integerValue] + 1];
            [_tableView reloadData];
        }
        
        if (finish)
            finish();        
    }];
}

#pragma mark - MPSegmentedControlDelegate
- (void)segBtnClickWithTitleIndex:(NSInteger)index {
    if (index == 0) {
        _urlString = PARTICPANCE_COMMENTLIST_URL;
        _type = @"count";
    } else {
        _urlString = PARTICPANCE_COMMENTLIST_TIME_URL;
        _type = @"time";
    }
    _offset = 0;
    _isLoadMore = NO;
    [self requestData];
    [self showHUD];
}

#pragma mark - Method
- (void)insertGentieModelToDB:(NSArray *)array {
    [self.cdManager deleteGentieModelWithWithPage:[NSString stringWithFormat:@"%ld",_offset]
                                        gentie_id:_gentie_id
                                             type:_type];
    for (GentieModel *model in array) {
        model.page = [NSString stringWithFormat:@"%ld",_offset];
        model.type = _type;
        model.gentie_id = self.gentie_id;
        [self.cdManager insertGentieModelInDB:model];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pinglun"]) {
        UINavigationController *nav = segue.destinationViewController;
        PinglunViewController *vc = nav.viewControllers[0];
        vc.topic_id = self.gentie_id;
    }
}


@end
