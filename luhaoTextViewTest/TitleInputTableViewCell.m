//
//  TitleInputTableViewCell.m
//  luhaoTextViewTest
//
//  Created by luhao on 15/10/17.
//  Copyright © 2015年 vxia. All rights reserved.
//

#import "TitleInputTableViewCell.h"

@interface TitleInputTableViewCell () <LUHTextViewDelegate>

@end

@implementation TitleInputTableViewCell

- (instancetype)initCellAtIndexPath:(NSIndexPath *)indexPath placeHolderTitle
                                   :(NSString *)placeHolder text:(NSString *)text
{
    self = [super init];
    if (self) {
        self.indexPath = indexPath;
        self.textView = (LUHTextView *)[TitleInputTableViewCell attributTextView];
        self.textView.luhTextViewDelegate = self;
        self.textView.text = text;
        self.textView.placeHolderLabel.text = placeHolder;
        [self.textView refreshPlaceHolderLabel];
        [self.contentView addSubview:self.textView];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - LUHTextViewDelegate
- (void)textView:(UITextView *)textView rowChangeToNumber:(int)rowNum height:(CGFloat)height
{
    if ([self.titleInputCellDelegate respondsToSelector:@selector(heightWillChangedTitleInputCell:)]) {
        [self.titleInputCellDelegate heightWillChangedTitleInputCell:self];
    }
    
    if ([self.titleInputCellDelegate respondsToSelector:@selector(heightDidChangedTitleInputCell:)]) {
        [self.titleInputCellDelegate heightDidChangedTitleInputCell:self];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.titleInputCellDelegate respondsToSelector:@selector(cellTextDidChange:)]) {
        [self.titleInputCellDelegate cellTextDidChange:self];
    }
}

#pragma mark - public method
+ (CGFloat)calculateText:(NSString *)string
{
    UITextView *textView = [TitleInputTableViewCell attributTextView];
    textView.text = string;
    CGSize size = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, FLT_MAX)];
    CGFloat cellHeight = size.height + 2*kTitleInputCellVerticalPadding;
    return cellHeight >= kTitleInputCellHeigntMin ? cellHeight : kTitleInputCellHeigntMin;
}

//字体模板, 以此模板计算 cell高度
+ (UITextView *)attributTextView
{
    LUHTextView *tmpTextView = [[LUHTextView alloc] initWithFrame:CGRectMake(kTitleInputCellHorizontalPadding,
                                                                             kTitleInputCellVerticalPadding,
                                                                             [UIScreen mainScreen].bounds.size.width-2*kTitleInputCellHorizontalPadding,
                                                                             kTitleInputCellInternalHeigit)];
    tmpTextView.font = [UIFont systemFontOfSize:14];    //修改字体在这里修改
    tmpTextView.backgroundColor = [UIColor greenColor];
    return tmpTextView;
}

@end
