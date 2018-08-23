//
//  NSString+LTxVerification.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

/**
 * 字符串验证
 **/
#import <Foundation/Foundation.h>

@interface NSString (LTxVerification)

/**
 * 正则表达式验证
 **/
- (BOOL)ltx_isValidateByRegex:(NSString *)regex;

/**
 * 手机号验证
 **/
- (BOOL)ltx_isPhoneNumber;

/**
 * 邮箱验证
 **/
- (BOOL)ltx_isEmailAddress;

/**
 *  车牌号验证
 **/
- (BOOL)ltx_isCarNumber;

/**
 *  IP地址验证
 */
- (BOOL)ltx_isIPAddress;

/**
 *  Mac地址验证
 */
- (BOOL)ltx_isMacAddress;

/**
 *  网址验证
 */
- (BOOL)ltx_isValidUrl;

/**
 * 身份证验证
 * 精确身份证验证，参照网上现有的算法
 **/
- (BOOL)ltx_isIdentityCardNum;
/**
 *  银行卡验证
 *  参照网上现有的算法
 */
- (BOOL)ltx_bankCardluhmCheck;




/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)ltx_isValidWithMinLenth:(NSInteger)minLenth
                       maxLenth:(NSInteger)maxLenth
                 containChinese:(BOOL)containChinese
            firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)ltx_isValidWithMinLenth:(NSInteger)minLenth
                       maxLenth:(NSInteger)maxLenth
                 containChinese:(BOOL)containChinese
                  containDigtal:(BOOL)containDigtal
                  containLetter:(BOOL)containLetter
          containOtherCharacter:(NSString *)containOtherCharacter
            firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;
@end
