//
//  NSUserDefaults+LTxExtension.m
//  LTxCategories
//
//  Created by liang tong on 2018/10/9.
//

#import "NSUserDefaults+LTxExtension.h"

@implementation NSUserDefaults (LTxExtension)
///#begin
/**
 *    @brief    删除特定key对应的值。
 *    @param     key         key值
 */
///#end
+ (void)ltx_removeObjectForKey:(NSString *)key{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    [accountDefaults removeObjectForKey:key];
    [accountDefaults synchronize];
}

///#begin
/**
 *    @brief    获取UserDefaults中的特定key对应的值。
 *    @param     defaultName         key值
 */
///#end
+ (id)ltx_objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}
///#begin
/**
 *    @brief    向UserDefaults中设置对应的Key－Value键值对。
 *    @param     value               value值
 *    @param     defaultName         key值
 */
///#end
+ (void)ltx_setObject:(id)value forKey:(NSString *)defaultName{
    if (!value || [value isEqual:[NSNull null]] || !defaultName || [defaultName isEqual:[NSNull null]]) {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:defaultName];
    [userDefaults synchronize];
}
@end
