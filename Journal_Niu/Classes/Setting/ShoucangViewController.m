//
//  ShoucangViewController.m
//  Journal_Niu
//
//  Created by WP on 16/5/17.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "ShoucangViewController.h"
#import "MPSegmentedControl.h"
#import "YILINCell.h"
#import "LaughCell.h"
#import "LaughModel.h"
#import "YILINModel.h"
#import "YiLinDetailViewController.h"
#import "LaughDetailViewController.h"

@interface ShoucangViewController ()<UITableViewDelegate,UITableViewDataSource,MPSegmentedControlDelegate>

@end

@implementation ShoucangViewController
{
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *_arrayDS;
    NSString *_type;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
    [self searchDataInDB];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
}

- (void)initData {
    _arrayDS = [NSMutableArray array];
    _type = @"shoucang_yilin";
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    MPSegmentedControl *seg = [[MPSegmentedControl alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 44)];
    seg.delegate = self;
    [seg createSegUIWithTitles:@[@"意林",@"搞笑秀"]];
    [self.view addSubview:seg];
    
    [_tableView registerNib:[UINib nibWithNibName:@"YILINCell" bundle:nil] forCellReuseIdentifier:@"YILINCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"LaughCell" bundle:nil] forCellReuseIdentifier:@"LaughCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)searchDataInDB {
    [_arrayDS removeAllObjects];
    NSArray *array = [self.cdManager searchShoucangModelInDBWithtype:_type];
    [_arrayDS addObjectsFromArray:array];
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDS.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type rangeOfString:@"yilin"].length == 5) {
        static NSString *cellID = @"YILINCell";
        YILINCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        [cell updateYilinCellWithModel:_arrayDS[indexPath.row]];
        return cell;
    }
    static NSString *laughCellID = @"LaughCell";
    LaughCell *cell = [tableView dequeueReusableCellWithIdentifier:laughCellID forIndexPath:indexPath];
    [cell updateLaughCellWithModel:_arrayDS[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type rangeOfString:@"yilin"].length == 5) {
        return 87.0f;
    }
    LaughModel *model = _arrayDS[indexPath.row];
    CGFloat width = [model.width floatValue];
    CGFloat height = [model.height floatValue];
    height = height / (width / SCREEN_WIDTH);
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_type rangeOfString:@"yilin"].length == 5) {
        YILINCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        YILINModel *model = _arrayDS[indexPath.row];
        
        YiLinDetailViewController *vc = (id)[self initViewControllerWithStoryBoardID:@"yilindetail"];
        vc.yiLinDetail_id = model.detail_id;
        vc.text = model.title;
        vc.image = cell.iconImageView.image;
        vc.model = model;
        vc.model.type = @"shoucang_yilin";
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    LaughDetailViewController *laughDetailVC = (id)[self initViewControllerWithStoryBoardID:@"laughdetail"];
    LaughModel *model = _arrayDS[indexPath.row];
    laughDetailVC.detail_id = model.gid;
    laughDetailVC.shoucang_model = model;
    laughDetailVC.shoucang_model.type = @"shoucang_laugh";
    [self.navigationController pushViewController:laughDetailVC animated:NO];
}

#pragma mark - MPSegmentedControlDelegate
- (void)segBtnClickWithTitleIndex:(NSInteger)index {
    if (index == 0) {
        _type = @"shoucang_yilin";
    } else {
        _type = @"shoucang_laugh";
    }
    [self searchDataInDB];
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
