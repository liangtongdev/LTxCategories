//
//  NSDate+LTxExtension.m
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import "NSDate+LTxExtension.h"

@implementation NSDate (LTxExtension)

/**
 * 日期的格式化字符串
 **/
-(NSString*)ltx_stringWithFormate:(NSString*)formate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formate;
    NSString* dateStr = [formatter stringFromDate:self];
    return dateStr;
}

/**
 * 将字符串格式日期转换成日期
 **/
+(NSDate*)ltx_dateWithString:(NSString*)dateString formate:(NSString*)formate{
    NSDateFormatter* inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:formate];
    NSDate *date = [inputFormatter dateFromString:dateString];
    return date;
}

/**
 * 比较两个日期是否是同一天
 **/
-(BOOL)ltx_theSameDay:(NSDate*)anotherDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp1 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    NSDateComponents *comp2 = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:anotherDate];
    return ([comp1 year] == [comp2 year] && [comp1 month] == [comp2 month] && [comp1 day] == [comp2 day]);
}

/**
 * 格式化描述日期
 * 比如：x分钟前/x小时前/昨天/x天前/x个月前/x年前
 **/
-(NSString*)ltx_simpleDescription{
    
    NSString* retTimeDesc;
    NSTimeInterval time =  [[NSDate date] timeIntervalSinceDate:self];
    if (time < LT_DATE_MINUTE) {//不到1分钟
        retTimeDesc = @"刚刚";
    }else if (time < LT_DATE_HOUR){//不到1小时
        retTimeDesc = [NSString stringWithFormat:@"%.0f分钟前",time / LT_DATE_MINUTE];
    }else if (time < LT_DATE_DAY){//不到1天
        retTimeDesc = [NSString stringWithFormat:@"%.0f小时前",time / LT_DATE_HOUR];
    }else if (time < LT_DATE_MONTH){//不到1月
        retTimeDesc = [NSString stringWithFormat:@"%.0f天前",time / LT_DATE_DAY];
    }else if (time < LT_DATE_YEAR){//不到1年
        retTimeDesc = [NSString stringWithFormat:@"%.0f个月前",time / LT_DATE_MONTH];
    }else{
        retTimeDesc = [NSString stringWithFormat:@"%.0f年前",time / LT_DATE_YEAR];
    }
    return retTimeDesc;
}
/**
 * 格式化描述日期
 * 比如：x分钟前/x小时前/昨天/x天前/x个月前/x年前
 **/
+(NSString*)ltx_simpleDescriptionWithString:(NSString*)dateString formate:(NSString*)formate{
    NSDate* date = [NSDate ltx_dateWithString:dateString formate:formate];
    return [date ltx_simpleDescription];
}
@end
