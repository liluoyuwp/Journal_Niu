//
//  LaughDetailViewController.m
//  Journal_Niu
//
//  Created by WP on 16/4/22.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "LaughDetailViewController.h"
#import "ImagesModel.h"
#import "UIImageView+WebCache.h"

@interface LaughDetailViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *xiazaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shoucangBtn;

@end

@implementation LaughDetailViewController
{
    ImagesModel *_model;
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
    
    [self requestData];
    
    [self updateShoucangBtn];
}

- (void)initData {
    
}

- (void)initUI {
    self.shoucangBtn.clipsToBounds = YES;
    self.shoucangBtn.layer.cornerRadius = 4.5f;
    self.xiazaiBtn.clipsToBounds = YES;
    self.xiazaiBtn.layer.cornerRadius = 4.5f;
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rect = CGRectMake(0, SCREEN_HEIGHT/2 - 150, SCREEN_WIDTH, 300);
    _imageView = [[UIImageView alloc] initWithFrame:rect];
    _imageView.userInteractionEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)]];
    [_scrollView addSubview:_imageView];
}

- (void)requestData {
    WS(weakSelf);
    [ImagesModel getImagesDateWithUrlString:[NSString stringWithFormat:KALEIDOSCOPE_LAUGH_INTO_URL,_detail_id] success:^(NSArray *array) {
        if (array.count > 0) {
            _model = array[0];
            [weakSelf refreshLaughDetailUI];
        } else {
            [WPAlertView showAlertWithMessage:@"数据出错" sureKey:^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)updateShoucangBtn {
    id obj = [self.cdManager searchShoucangModelInDBWithtype:@"shoucang_laugh" shoucang_id:_detail_id];
    if (![obj isKindOfClass:[NSString class]]) {
        self.shoucangBtn.selected = YES;
    }
}

- (void)refreshLaughDetailUI {
    WS(weakSelf);
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_model.icon]
                      placeholderImage:[UIImage imageNamed:@"缺省图"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                          if (image) {
                              _imageView.image = image;
                          } else {
                              _imageView.image = [UIImage imageNamed:@"缺省图"];
                          }
                          [weakSelf showImage:_imageView.image];
                      } ];
}

#pragma mark - button method
- (IBAction)shoucang:(UIButton *)sender {
    WS(weakSelf);
    if (sender.selected) {
        [WPAlertView showAlertWithMessage:@"确认取消收藏?" sureKey:^{
            [weakSelf.cdManager deleteShoucangModelWithWithtype:@"shoucang_laugh" shoucang_id:_detail_id];
            sender.selected = NO;
        } cancelKey:nil];
    } else {
        [self.cdManager insertShoucangModelInDB:self.shoucang_model];
        sender.selected = YES;
    }}

- (IBAction)xiazai:(UIButton *)sender {
    if (sender.selected) return;
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void *)contextInfo {
    
    if(!error){
        
        self.xiazaiBtn.selected = YES;
        [self.xiazaiBtn setTitle:@"已保存到本地图库" forState:UIControlStateSelected];
    }else{
        [WPAlertView showAlertWithTitle:@"" message:@"若继续,请授权访问相册" sureKey:^{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root=Privacy"]]) {
                
                //开启手机系统设置，授权访问相册
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy"]];            }
        } cancelKey:nil];
    }
}

-(void)showImage:(UIImage *)image{
    
    _imageView.frame = CGRectMake(0, (SCREEN_HEIGHT - image.size.height * SCREEN_WIDTH/image.size.width)/2, _imageView.frame.size.width, _imageView.frame.size.width * (image.size.height/image.size.width));

    // 设置UIScrollView初始化缩放级别
    [_scrollView setZoomScale:1];
}

- (void)hideImage:(UITapGestureRecognizer*)tap {
    [self.navigationController popViewControllerAnimated:NO];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
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
