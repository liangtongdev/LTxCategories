//
//  UIView+LTxConstraint.h
//  LTxCategories
//
//  Created by liangtong on 2018/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/***
 * 简单的约束
 ****/
@interface UIView (LTxConstraint)

/***
 * 设置subView的大小
 **/
- (void)ltx_pinAllEdgesOfSubview:(UIView *)subview;

- (void)ltx_pinSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)edgeInsets;
@end

NS_ASSUME_NONNULL_END
