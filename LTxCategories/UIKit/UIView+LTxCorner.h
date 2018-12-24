//
//  UIView+LTxCorner.h
//  LTxCategories
//
//  Created by liangtong on 2018/12/24.
//

#import <UIKit/UIKit.h>
#import "LTxCorner.h"

NS_ASSUME_NONNULL_BEGIN

/****
 * 给UIView添加圆角
 ***/

@interface UIView (LTxCorner)

//圆角类别
@property (nonatomic, assign) LTxCornerType cornerType;

//圆角大小
@property (nonatomic, assign) CGFloat cornerRadius;


//其他
@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) UIBezierPath * path;
@end

NS_ASSUME_NONNULL_END
