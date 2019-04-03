//
//  UIView+LTxCorner.m
//  LTxCategories
//
//  Created by liangtong on 2018/12/24.
//

#import "UIView+LTxCorner.h"
#import <objc/runtime.h>

NSString const *ltx_view_maskLayer = @"ltx_view_maskLayer";
NSString const *ltx_view_path = @"ltx_view_path";

@implementation UIView (LTxCorner)


#pragma mark - 切圆角的方法
//添加椭圆
-(void)ltx_addOval{
    [self ltx_removeCorner];
    self.maskLayer = [CAShapeLayer layer];
    [self.layer setMask:self.maskLayer];
    self.path =[UIBezierPath bezierPathWithOvalInRect:self.bounds];
    self.maskLayer.path = self.path.CGPath;
}
//添加圆角矩形
-(void)ltx_addRoundedCornerWithRadius:(CGFloat)cornerRadius{
    [self ltx_removeCorner];
    self.maskLayer = [CAShapeLayer layer];
    [self.layer setMask:self.maskLayer];
    self.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    self.maskLayer.path = self.path.CGPath;
}
//指定位置圆角矩形
-(void)ltx_addRoundedCornerWithCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii{
    [self ltx_removeCorner];
    self.maskLayer = [CAShapeLayer layer];
    [self.layer setMask:self.maskLayer];
    self.path =[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    self.maskLayer.path = self.path.CGPath;
}
//以某个中心点画弧线
-(void)ltx_addArcsWithCenter:(CGPoint)center radius:(CGFloat)radius  startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise{
    [self ltx_removeCorner];
    self.maskLayer = [CAShapeLayer layer];
    [self.layer setMask:self.maskLayer];
    self.path =[UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    self.maskLayer.path = self.path.CGPath;
}

//添加四次曲线 - QuadCurve
-(void)ltx_addQuadCurveWithType:(LTxCornerType)cornerType cornerRadius:(CGFloat)cornerRadius{
    if (cornerRadius > 0 && cornerType > 0) {
        [self ltx_removeCorner];
        self.maskLayer = [CAShapeLayer layer];
        [self.layer setMask:self.maskLayer];
        self.path = [UIBezierPath bezierPath];
        
        CGSize size = self.bounds.size;
        //开始描画动作
        [LTxCorner addCornerWithPath:self.path cornerRadius:cornerRadius cornerType:cornerType size:size];
        
        self.maskLayer.path = self.path.CGPath;
        
    }else{
        [self ltx_removeCorner];
    }
}

//移除圆角
-(void)ltx_removeCorner{
    [self.path removeAllPoints];
    [self.maskLayer removeFromSuperlayer];
    self.path = nil;
    self.maskLayer = nil;
}

#pragma mark - Getter && Setter
-(CAShapeLayer*)maskLayer{
    return objc_getAssociatedObject(self, &ltx_view_maskLayer);
}
-(void)setMaskLayer:(CAShapeLayer * )maskLayer{
    if (maskLayer == nil) {
        return;
    }
    objc_setAssociatedObject(self, &ltx_view_maskLayer, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIBezierPath*)path{
    return objc_getAssociatedObject(self, &ltx_view_path);
}
-(void)setPath:(UIBezierPath * )path{
    if(path == nil){
        return;
    }
    objc_setAssociatedObject(self, &ltx_view_path, path, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
