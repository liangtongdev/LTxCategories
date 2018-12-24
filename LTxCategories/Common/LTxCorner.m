//
//  LTxCorner.m
//  LTxCategories
//
//  Created by liangtong on 2018/12/24.
//

#import "LTxCorner.h"

@implementation LTxCorner

/**
 * 给特定的path添加圆角轮廓点
 **/
+(void)addCornerWithPath:(UIBezierPath*)path cornerRadius:(CGFloat)cornerRadius cornerType:(LTxCornerType)cornerType size:(CGSize)size{
    //4个点。右上&右下&左下&左上
    CGPoint controlPoint_1 = CGPointMake(size.width, 0);
    CGPoint controlPoint_2 = CGPointMake(size.width, size.height);
    CGPoint controlPoint_3 = CGPointMake(0, size.height);
    CGPoint controlPoint_4 = CGPointMake(0, 0);
    
    //8个拐点。从左上右绕一圈到左上下
    CGPoint startPoint = CGPointMake(cornerRadius, 0);
    CGPoint point_1 = CGPointMake(size.width - cornerRadius, 0);
    CGPoint point_2 = CGPointMake(size.width, cornerRadius);
    CGPoint point_3 = CGPointMake(size.width, size.height - cornerRadius);
    CGPoint point_4 = CGPointMake(size.width - cornerRadius, size.height);
    CGPoint point_5 = CGPointMake(cornerRadius, size.height);
    CGPoint point_6 = CGPointMake(0, size.height - cornerRadius);
    CGPoint endPoint = CGPointMake(0, cornerRadius);
    
    //贝塞尔path
    [path moveToPoint:startPoint];
    [path addLineToPoint:point_1];
    //右上角
    if (cornerType & LTxCornerTopRight) {//包含
        [path addQuadCurveToPoint:point_2 controlPoint:controlPoint_1];
    }else{
        [path addLineToPoint:controlPoint_1];
        [path addLineToPoint:point_2];
    }
    
    [path addLineToPoint:point_3];
    //右下角
    if (cornerType & LTxCornerBottomRight) {//包含
        [path addQuadCurveToPoint:point_4 controlPoint:controlPoint_2];
    }else{
        [path addLineToPoint:controlPoint_2];
        [path addLineToPoint:point_4];
    }
    
    [path addLineToPoint:point_5];
    
    //左下角
    if (cornerType & LTxCornerBottomLeft) {//包含
        [path addQuadCurveToPoint:point_6 controlPoint:controlPoint_3];
    }else{
        [path addLineToPoint:controlPoint_3];
        [path addLineToPoint:point_6];
    }
    
    [path addLineToPoint:endPoint];
    
    //左上角
    if (cornerType & LTxCornerTopLeft) {//包含
        [path addQuadCurveToPoint:startPoint controlPoint:controlPoint_4];
    }else{
        [path addLineToPoint:controlPoint_4];
        [path addLineToPoint:startPoint];
    }
    
    [path closePath];
}
@end
