//
//  GuideViewController.m
//  Journal_Niu
//
//  Created by 黎洛羽 on 16/6/2.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "GuideViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface GuideViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *jinruAiyilin;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation GuideViewController
{
    MPMoviePlayerController *_moviePlayer;
    NSString *_avaudioSessionCategory;
    NSTimer *_timer;
    NSArray *_arrayDS;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self initUI];
    
    [self initMovie];
    
    [self setTimer];
}

- (void)initData {
    _arrayDS = @[@"热爱生活",@"热爱运动",@"热爱意林",@"欢迎进入阅读的世界..."];
}

- (void)initUI {
    _scrollView.contentSize = CGSizeMake(_arrayDS.count * SCREEN_WIDTH, 0);
    _infoLabel.text = _arrayDS[0];
    self.jinruAiyilin.layer.cornerRadius = 3.0f;
}

- (void)initMovie {
    
    _avaudioSessionCategory = [AVAudioSession sharedInstance].category;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"guide.mp4" ofType:nil]];
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    _moviePlayer.view.frame = self.view.bounds;
    _moviePlayer.shouldAutoplay = YES;
    _moviePlayer.controlStyle = MPMovieControlStyleNone;
    _moviePlayer.fullscreen = YES;
    _moviePlayer.repeatMode = MPMovieRepeatModeOne;
    [_moviePlayer play];
    
    [self.view insertSubview:_moviePlayer.view belowSubview:_bgView];
}

- (void)setTimer {
    [self endTimer];
    _timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(timerChanged) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timerChanged {
    _pageControl.currentPage = (_pageControl.currentPage + 1) % 4;
    _infoLabel.text = _arrayDS[_pageControl.currentPage];
    [_scrollView setContentOffset:CGPointMake((_pageControl.currentPage) * SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark - button click
- (IBAction)jinru:(id)sender {
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    [self endTimer];
    
    [[AVAudioSession sharedInstance] setCategory:_avaudioSessionCategory error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:GUIDE_KEY forKey:GUIDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle: nil ];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"tabbar"];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    if (page== - 1) {
        self.pageControl.currentPage = 3;
    } else if (page == 4) {
        self.pageControl.currentPage = 0; 
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    self.pageControl.currentPage = page;
    _infoLabel.text = _arrayDS[page];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setTimer];
    
}

//隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
