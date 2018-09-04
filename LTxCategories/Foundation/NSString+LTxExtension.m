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




@end
