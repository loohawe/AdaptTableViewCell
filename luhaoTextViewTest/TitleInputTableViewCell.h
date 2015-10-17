//
//  TitleInputTableViewCell.h
//  luhaoTextViewTest
//
//  Created by luhao on 15/10/17.
//  Copyright © 2015年 vxia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHTextView.h"

#define kTitleInputCellHeigntMin 44         //cell最小高度
#define kTitleInputCellHorizontalPadding 4  //textView 到 Cell 左边的间距
#define kTitleInputCellVerticalPadding 5    //textView 到 Cell 顶部的间距
#define kTitleInputCellInternalHeigit 33    //textView 的高度

@class TitleInputTableViewCell;
@protocol TitleInputTableViewCellDelegate <NSObject>
- (void)heightWillChangedTitleInputCell:(TitleInputTableViewCell *)cell;
- (void)heightDidChangedTitleInputCell:(TitleInputTableViewCell *)cell;
- (void)cellTextDidChange:(TitleInputTableViewCell *)cell;
@end

@interface TitleInputTableViewCell : UITableViewCell

- (instancetype)initCellAtIndexPath:(NSIndexPath *)indexPath placeHolderTitle:(NSString *)placeHolder text:(NSString *)text;

@property (nonatomic) LUHTextView *textView;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic, weak) id<TitleInputTableViewCellDelegate> titleInputCellDelegate;

+ (CGFloat)calculateText:(NSString *)string;

//计算高度模板, 要修改字体从这里修改
+ (UITextView *)attributTextView;

@end
