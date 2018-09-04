//
//  NSDate+LTxExtension.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LT_DATE_MINUTE    60
#define LT_DATE_HOUR    3600
#define LT_DATE_DAY    86400
#define LT_DATE_MONTH    2592000
#define LT_DATE_YEAR    31556926

/**
 * 关于日期的扩展
 **/
@interface NSDate (LTxExtension)

/**
 * 日期的格式化字符串
 **/
-(NSString*)ltx_stringWithFormate:(NSString*)formate;

/**
 * 将字符串格式日期转换成日期
 **/
+(NSDate*)ltx_dateWithString:(NSString*)dateString formate:(NSString*)formate;

/**
 * 比较两个日期是否是同一天
 **/
-(BOOL)ltx_theSameDay:(NSDate*)anotherDate;

/**
 * 格式化描述日期
 * 比如：x分钟前/x小时前/昨天/x天前/x个月前/x年前
 **/
-(NSString*)ltx_simpleDescription;
/**
 * 格式化描述日期
 * 比如：x分钟前/x小时前/昨天/x天前/x个月前/x年前
 **/
+(NSString*)ltx_simpleDescriptionWithString:(NSString*)dateString formate:(NSString*)formate;

@end
