//
//  UITextView+LTxPlaceHolder.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 给文本框添加placeholder
 * 就是创建一个相同的TextView，与当前对象关联。并根据焦点显示/隐藏创建的TextView
 **/
@interface UITextView (LTxPlaceHolder) <UITextViewDelegate>
@property (nonatomic, strong) UITextView *ltx_placeHolderTextView;
- (void)ltx_addPlaceHolder:(NSString *)placeHolder;
@end
