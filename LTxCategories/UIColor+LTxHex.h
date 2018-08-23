//
//  UIColor+LTxHex.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 颜色扩展
 * 基于十六进制字符串或者数值进行转换
 **/
@interface UIColor (LTxHex)

+ (UIColor *)ltx_colorWithHex:(UInt32)hex;
+ (UIColor *)ltx_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)ltx_colorWithHexString:(NSString *)hexString;
- (NSString *)ltx_HEXString;
@end
