//
//  SettingViewController.m
//  Journal_Niu
//
//  Created by WP on 16/5/17.
//  Copyright © 2016年 yangyang.niu. All rights reserved.
//

#import "SettingViewController.h"
#import "SDWebImageManager.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cacheBtn;

@end

@implementation SettingViewController
{
    NSString *_cacheStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self initUI];
    
    [self updateCacheSize];
}

- (void)initData {
    _cacheStr = [NSString stringWithFormat:@"%.1fM",[self getCacheSize]];
}

- (void)initUI {
    self.tabBarController.tabBar.hidden = YES;
    
    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString:@"清除缓存"];
    [attribute addAttributes: @{NSForegroundColorAttributeName: [UIColor lightGrayColor]} range: NSMakeRange(0, @"清除缓存".length)];
    [self.cacheBtn setAttributedTitle:attribute forState:UIControlStateHighlighted];
}

- (void)updateCacheSize {
    
    NSString *str = [NSString stringWithFormat:@"清除缓存(%@)",_cacheStr];
    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString: str];
    [attribute addAttributes: @{NSForegroundColorAttributeName: [UIColor redColor]} range: NSMakeRange(4, str.length - 4)];
    [self.cacheBtn setAttributedTitle:attribute forState:UIControlStateNormal];
}

#pragma mark - button action.
- (IBAction)clearBtn:(id)sender {
    if ([_cacheStr isEqualToString:@"0.0M"]) {
        [WPAlertView showAlertWithMessage:@"暂无缓存"
                  autoDisappearAfterDelay:1];
        return;
    }
    WS(weakSelf);
    [WPAlertView showAlertWithTitle:@"" message:@"确定清空本地缓存数据(包括图片和美文详情)?" cancelKeyTitle:@"取消" rightKeyTitle:@"清除" rightKey:^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] cleanDisk];
        
        [weakSelf clearCacheFinder];
        [weakSelf performSelector:@selector(clearOver:) withObject:hud afterDelay:1];
    } cancelKey:nil];
}

#pragma mark - methods
- (CGFloat)getCacheSize {
    NSUInteger byteSize = [SDImageCache sharedImageCache].getSize;
    // M
    CGFloat imageSize = byteSize / 1000.0 / 1000.0;
    
    NSString *docDir = [NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject],@"/URLCACHE"];
    
    CGFloat imCache = [self folderSizeAtPath:docDir];
    
    return imageSize + imCache;
}

- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (CGFloat)folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1000.0 * 1000.0);
}

- (void)clearOver:(MBProgressHUD *)hud {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clear_hud_ok"]];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"成功";
    [hud hide:YES afterDelay:1];
}

- (void)clearCacheFinder {
    NSString *cachePath = [NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject],@"/URLCACHE"];

    if ([[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {

        [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
        _cacheStr = @"0.0M";
        [self updateCacheSize];
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
