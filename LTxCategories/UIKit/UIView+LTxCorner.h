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
 * 给UIView添加圆角(四次曲线 - QuadCurve)
 * 如果仅仅是添加角圆弧，可以通过以下方法创建贝塞尔路径
 * + (UIBezierPath *)bezierPathWithOvalInRect:(CGRect)rect;
 * + (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
 * + (UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
 * + (UIBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
 ***/

@interface UIView (LTxCorner)
//属性
@property (nonatomic, strong, nullable) CAShapeLayer * maskLayer;
@property (nonatomic, strong, nullable) UIBezierPath * path;


#pragma mark - 切圆角的方法
//添加椭圆
-(void)ltx_addOval;
//添加圆角矩形
-(void)ltx_addRoundedCornerWithRadius:(CGFloat)cornerRadius;
//指定位置圆角矩形
-(void)ltx_addRoundedCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
//以某个中心点画弧线
-(void)ltx_addArcsWithCenter:(CGPoint)center radius:(CGFloat)radius  startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
//添加四次曲线 - QuadCurve
-(void)ltx_addQuadCurveWithType:(LTxCornerType)cornerType cornerRadius:(CGFloat)cornerRadius;

//移除圆角
-(void)ltx_removeCorner;

@end

NS_ASSUME_NONNULL_END
