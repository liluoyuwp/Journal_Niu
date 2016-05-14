/**
 * @file    MPSegmentedControl.m
 * @brief   MPSegmentedControl
 * @author  niu
 * @version 1.0
 * @date    2016-05-10
 */

#import "MPSegmentedControl.h"
#import "MPSegButton.h"

@implementation MPSegmentedControl
{
    UIView *_lineView;          //!< _lineView the line view.
    NSMutableArray *_arrBtns;   //!< _arrBtns the array of seg buttons.
    CGFloat _btnWidth;          //!< _btnWidth the width of button.
    NSInteger _lastTag;         //!< _lastTag the tag of last click button.
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIView *viewTopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)];
    viewTopLine.backgroundColor = [UIColor colorWithRed:180/255.0 green:182/255.0 blue:180/255.0 alpha:1];
    [self addSubview:viewTopLine];
    
    UIView *viewBottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1)];
    viewBottomLine.backgroundColor = [UIColor colorWithRed:180/255.0 green:182/255.0 blue:180/255.0 alpha:1];
    [self addSubview:viewBottomLine];
    
    _lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
}

- (void)initData {
    _lineColor          = [UIColor redColor];
    _titleColor         = [UIColor redColor];
    _titlePlaceColor    = [UIColor lightGrayColor];
    _time               = 0.2;
    _arrBtns            = [NSMutableArray array];
    _lastTag            = 0;
}

- (void)createSegUIWithTitles:(NSArray *)titles {
    CGFloat x = 0;
    CGFloat y = 0;
    _btnWidth = self.frame.size.width / (titles.count * 1.0);
    CGFloat btnHeight = CGRectGetHeight(self.frame);
    
    // update line.
    _lineView.frame = CGRectMake(x + 5, CGRectGetHeight(self.frame) - 2, _btnWidth - 10, 2);
    _lineView.backgroundColor = _lineColor;

    // create buttons.
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        MPSegButton *button = [MPSegButton createSegButtonWithTitle:title
                                                         titleColor:_titleColor
                                                    titlePlaceColor:_titlePlaceColor
                                                              frame:CGRectMake(x, y, _btnWidth, btnHeight)
                                                             target:self
                                                             action:@selector(segButtonClick:)
                                                          buttonTag:i];
        
        [self addSubview:button];
        x += _btnWidth;
        
        if (i == 0) button.selected = YES;
        [_arrBtns addObject:button];
    }
}

- (void)segButtonClick:(MPSegButton *)btn {
    if (btn.buttonTag == _lastTag) return;
    _lastTag = btn.buttonTag;
    
    [self changeLineViewWithX:btn.buttonTag];
    [self changeButtonStatusWithSegBthTag:btn.buttonTag];
    
    if ([self.delegate respondsToSelector:@selector(segBtnClickWithTitleIndex:)]) {
        [self.delegate segBtnClickWithTitleIndex:btn.buttonTag];
    }
}

- (void)changeLineViewWithX:(NSInteger)x {
    [UIView animateWithDuration:_time animations:^{
        _lineView.frame = CGRectMake(x * _btnWidth + 5, CGRectGetHeight(self.frame) - 2, _btnWidth - 10, 2);
    }];
}

- (void)changeButtonStatusWithSegBthTag:(NSInteger)btnTag {
    for (MPSegButton *btn in _arrBtns) {
        if (btn.buttonTag == btnTag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

@end
