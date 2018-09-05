//
//  UINavigationBar+LTxAwesome.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

//  Copyright (c) 2015 ltebean. All rights reserved.
//  https://github.com/ltebean/LTNavigationBar

#import <UIKit/UIKit.h>

/**
 * 利用runtime机制，动态给navigationBar添加subView，设置纯色背景图片
 **/

@interface UINavigationBar (LTxAwesome)
- (void)ltx_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ltx_setElementsAlpha:(CGFloat)alpha;
- (void)ltx_setTranslationY:(CGFloat)translationY;
- (void)ltx_reset;
@end
