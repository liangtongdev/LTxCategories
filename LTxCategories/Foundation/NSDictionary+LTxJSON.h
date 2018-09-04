//
//  NSDictionary+LTxJSON.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 字典转JSON字符串
 **/
@interface NSDictionary (LTxJSON)

/**
 *  字典转JSON字符串
 **/
-(NSString *)ltx_JSONString;

/**
 * JSON字符串转换成字典
 **/
+(NSDictionary*)ltx_dictionaryFromJSON:(NSString*)jsonString;

@end
