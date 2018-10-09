//
//  NSUserDefaults+LTxExtension.h
//  LTxCategories
//
//  Created by liang tong on 2018/10/9.
//

#import <Foundation/Foundation.h>

/**
 * 安全访问
 **/
@interface NSUserDefaults (LTxExtension)

///#begin
/**
 *    @brief    删除特定key对应的值。
 *    @param     key         key值
 */
///#end
+ (void)ltx_removeObjectForKey:(NSString *)key;


///#begin
/**
 *    @brief    获取UserDefaults中的特定key对应的值。
 *    @param     defaultName         key值
 */
///#end
+ (id)ltx_objectForKey:(NSString *)defaultName;
///#begin
/**
 *    @brief    向UserDefaults中设置对应的Key－Value键值对。
 *    @param     value               value值
 *    @param     defaultName         key值
 */
///#end
+ (void)ltx_setObject:(id)value forKey:(NSString *)defaultName;

@end
