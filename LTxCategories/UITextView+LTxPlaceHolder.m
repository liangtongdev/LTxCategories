//
//  UITextView+LTxPlaceHolder.m
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "UITextView+LTxPlaceHolder.h"
#import <objc/runtime.h>
static const char *ltx_placeHolderTextView = "ltx_placeHolderTextView";
@implementation UITextView (LTxPlaceHolder)
- (UITextView *)ltx_placeHolderTextView {
    return objc_getAssociatedObject(self, ltx_placeHolderTextView);
}
- (void)setLtx_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, ltx_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)ltx_addPlaceHolder:(NSString *)placeHolder {
    if (![self ltx_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setLtx_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
    }
    self.ltx_placeHolderTextView.text = placeHolder;
}
# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(NSNotification *)noti {
    self.ltx_placeHolderTextView.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.ltx_placeHolderTextView.hidden = NO;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
