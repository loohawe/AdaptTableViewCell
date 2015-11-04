//
//  LUHTextView.m
//  vxia-2.0
//
//  Created by luhao on 15/10/15.
//  Copyright © 2015年 vxia. All rights reserved.
//

#define LUHTextView_height_max 1000

#import "LUHTextView.h"

@interface LUHTextView () <UITextViewDelegate>
@property (nonatomic) CGFloat kLUHTextView_height_min;
@property (nonatomic) CGFloat kLUHTextView_height_min_format;
@property (nonatomic) CGFloat baseHeight;
@property (nonatomic) CGFloat baseHeightChangeOneLine;
@property (nonatomic) CGFloat oneLineHeight;
@end

@implementation LUHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _kLUHTextView_height_min = frame.size.height;
        self.delegate = self;
        self.textColor = [UIColor blackColor];
        [self addSubview:self.placeHolderLabel];
        self.placeHolderLabel.textColor = [UIColor grayColor];
        self.scrollEnabled = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self showPlaceHolder:NO];
    if ([self.luhTextViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.luhTextViewDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self refreshPlaceHolderLabel];
    if ([self.luhTextViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.luhTextViewDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.luhTextViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.luhTextViewDelegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.luhTextViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.luhTextViewDelegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.luhTextViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.luhTextViewDelegate textViewDidChange:textView];
    }

    CGFloat height = [self textViewHeightForAttributedText:textView.attributedText andWidth:self.frame.size.width];
    [self setBaseHeight:height]; //只会设置一次的属性
    if (height != self.baseHeight) {
        [self setBaseHeightChangeOneLine:height];
    }
    
    CGFloat selfHeight = self.frame.size.height;
    if ((height != selfHeight&&height>_kLUHTextView_height_min)||height==_kLUHTextView_height_min_format) {
        height = height==_kLUHTextView_height_min_format?_kLUHTextView_height_min:height;
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.2 animations:^{
            [weakself setFrame:CGRectMake(self.frame.origin.x,
                                      self.frame.origin.y,
                                      self.frame.size.width,
                                      height)];
        }];
        int lineCount = (self.oneLineHeight==0)?0:(height /_oneLineHeight);
        if ([self.luhTextViewDelegate respondsToSelector:@selector(textView:rowChangeToNumber:height:)]) {
            [self.luhTextViewDelegate textView:self rowChangeToNumber:lineCount height:height];
        }
    }
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}

#pragma mark - public method

- (void)setBaseHeight:(CGFloat)baseHeight
{
    if (_baseHeight == 0) {
        _baseHeight = baseHeight;
    }
}

- (void)setBaseHeightChangeOneLine:(CGFloat)baseHeightChangeOneLine
{
    if (_baseHeightChangeOneLine == 0) {
        if (self.baseHeight != 0) {
            _baseHeightChangeOneLine = baseHeightChangeOneLine;
            [self setupOneLineHeight];
        }
    }
}

- (void)setupOneLineHeight
{
    if (self.baseHeight != 0 && self.baseHeightChangeOneLine != 0) {
        BOOL compare = self.baseHeight > self.baseHeightChangeOneLine;
        _oneLineHeight = compare ? (self.baseHeight-self.baseHeightChangeOneLine) : (self.baseHeightChangeOneLine-self.baseHeight);
        int a = self.baseHeight/_oneLineHeight;
        CGFloat b = self.baseHeight - (_oneLineHeight*a);
        int count = _kLUHTextView_height_min/_oneLineHeight;
        _kLUHTextView_height_min_format = b == 0 ? 0 : _oneLineHeight*count + b;
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];

    CGFloat height = [self textViewHeightForAttributedText:self.attributedText andWidth:self.frame.size.width];
    [self setBaseHeight:height];
    if (height != self.frame.size.height && height > _kLUHTextView_height_min) {
        [self setFrame:CGRectMake(self.frame.origin.x,
                                  self.frame.origin.y,
                                  self.frame.size.width,
                                  height)];
    }
}

#pragma mark - private method

- (void)refreshPlaceHolderLabel
{
    if (self.text.length > 0) {
        [self showPlaceHolder:NO];
    }
    else {
        [self showPlaceHolder:YES];
    }
}

- (void)showPlaceHolder:(BOOL)show
{
    if (show) {
        [self.placeHolderLabel setTextColor:[UIColor grayColor]];
    }
    else {
        [self.placeHolderLabel setTextColor:[UIColor clearColor]];
    }
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentInset.left+8,
                                                                      self.contentInset.top,
                                                                      self.frame.size.width,
                                                                      self.frame.size.height)];
    }
    return _placeHolderLabel;
}

- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

@end
