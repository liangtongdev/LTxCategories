//
//  UIButton+LTxLoading.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import <UIKit/UIKit.h>

/**
 * 添加UIActivityIndicatorView
 * 利用runtime机制
 **/
@interface UIButton (LTxLoading)

/**
 * 显示
 **/
- (void)ltx_startAnimating;

/**
 * 隐藏
 **/
- (void)ltx_stopAnimating;
@end
