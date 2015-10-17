//
//  LUHTextView.h
//  vxia-2.0
//
//  Created by luhao on 15/10/15.
//  Copyright © 2015年 vxia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LUHTextViewDelegate <UITextViewDelegate>
@optional
- (void)textView:(UITextView *)textView rowChangeToNumber:(int)rowNum height:(CGFloat)height;
@end

@interface LUHTextView : UITextView

@property (nonatomic, weak) id<LUHTextViewDelegate> luhTextViewDelegate;
@property (nonatomic) UILabel *placeHolderLabel;
- (void)refreshPlaceHolderLabel;

@end
