//
//  NSString+LTxExtension.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 字符串的扩展
 **/
@interface NSString (LTxExtension)


/**
 * 去除空格
 **/
- (NSString *)ltx_trimmingWhitespace;


/**
 * URL地址编码-主要针对中文
 **/
- (NSURL*)ltx_urlAddress;


@end
