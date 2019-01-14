//
//  NSString+LTxExtension.m
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "NSString+LTxExtension.h"

@implementation NSString (LTxExtension)

/**
 * 去除空格
 **/
- (NSString *)ltx_trimmingWhitespace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


/**
 * URL地址编码-主要针对中文
 **/
- (NSURL*)ltx_urlAddress{
    if (!self || [[self ltx_trimmingWhitespace] isEqualToString:@""]) {
        return nil;
    }
    NSString* urlString = [self stringByAddingPercentEncodingWithAllowedCharacters:
                           [NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:urlString];
}


@end
