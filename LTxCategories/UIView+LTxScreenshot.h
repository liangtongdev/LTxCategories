//
//  UIView+LTxScreenshot.h
//  LTxCategories
//
//  Created by liangtong on 2018/8/23.
//  Copyright © 2018年 LIANGTONG. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 屏幕截图
 **/
@interface UIView (LTxScreenshot)
/**
 *  @brief  view截图
 *
 *  @return 截图
 */
- (UIImage *)ltx_screenshot;
@end
