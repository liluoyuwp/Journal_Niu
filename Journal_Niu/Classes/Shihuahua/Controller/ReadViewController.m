//
//  ReadViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/21.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadModel.h"
#import "UIImageView+WebCache.h"

@interface ReadViewController ()<UIScrollViewDelegate,UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ReadViewController
{
    NSMutableArray *_arrayDS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self initUI];
    
    [self requestData];
}

- (void)initData {
    _arrayDS = [NSMutableArray array];
}

- (void)initUI {
    self.view.hidden = YES;
}

- (void)requestData {
    WS(weakSelf);
    [ReadModel getReadDataWithUrlString:KALEIDOSCOPE_MICROREAD_URL success:^(NSArray *array) {
        [_arrayDS addObjectsFromArray:array];
        if (_arrayDS.count > 0) {
            [weakSelf refreshUI];
        } else {
            [WPAlertView showAlertWithMessage:@"暂无数据" sureKey:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)refreshUI {
    _pageControl.numberOfPages = _arrayDS.count;
    _pageControl.currentPage = 0;
    
    ReadModel *model = _arrayDS[0];
    self.titleLabel.text = model.title;
    self.textView.text = model.des;
    
    _scrollView.contentSize = CGSizeMake(_arrayDS.count * SCREEN_WIDTH, 0);
    
    for (int i = 0; i < _arrayDS.count; i++) {
        ReadModel * model = _arrayDS[i];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_WIDTH * (187/320.0))];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"缺省图"]];
        [_scrollView addSubview:imageView];
    }
    self.view.hidden = NO;
}

#pragma mark - UIScrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _textView.contentOffset = CGPointZero;
    
    int page = scrollView.contentOffset.x / _scrollView.frame.size.width;
    ReadModel *model = _arrayDS[page];
    _titleLabel.text = model.title;
    _textView.text = model.des;
    _pageControl.currentPage = page;
}

@end
