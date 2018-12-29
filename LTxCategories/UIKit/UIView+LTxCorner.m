//
//  UIView+LTxCorner.m
//  LTxCategories
//
//  Created by liangtong on 2018/12/24.
//

#import "UIView+LTxCorner.h"
#import <objc/runtime.h>

NSString const *ltx_view_cornerType = @"ltx_view_cornerType";
NSString const *ltx_view_cornerRadius = @"ltx_view_cornerRadius";
NSString const *ltx_view_maskLayer = @"ltx_view_maskLayer";
NSString const *ltx_view_path = @"ltx_view_path";

@implementation UIView (LTxCorner)
@dynamic cornerType;
@dynamic cornerRadius;

-(void)ltx_updateViewCorner{
    if (self.cornerRadius > 0 && self.cornerType > 0) {
        if(!self.maskLayer){
            self.maskLayer = [CAShapeLayer layer];
            [self.layer setMask:self.maskLayer];
        }
        if (!self.path) {
            self.path = [UIBezierPath bezierPath];
        }
        CGSize size = self.bounds.size;
        //开始描画动作
        [LTxCorner addCornerWithPath:self.path cornerRadius:self.cornerRadius cornerType:self.cornerType size:size];
        
        self.maskLayer.path = self.path.CGPath;
        
    }else{
        [self.path removeAllPoints];
        [self.maskLayer removeFromSuperlayer];
    }
}


#pragma mark - Getter && Setter
-(LTxCornerType)cornerType{
    NSNumber *number = objc_getAssociatedObject(self, &ltx_view_cornerType);
    return number.unsignedIntegerValue;
}

-(void)setCornerType:(LTxCornerType)cornerType{
    NSNumber* number = [NSNumber numberWithUnsignedInteger:cornerType];
    objc_setAssociatedObject(self, &ltx_view_cornerType, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self ltx_updateViewCorner];
}

-(CGFloat)cornerRadius{
    NSNumber *number = objc_getAssociatedObject(self, &ltx_view_cornerRadius);
    return number.floatValue;
}
-(void)setCornerRadius:(CGFloat)cornerRadius{
    NSNumber* number = [NSNumber numberWithFloat:cornerRadius];
    objc_setAssociatedObject(self, &ltx_view_cornerRadius, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self ltx_updateViewCorner];
}

-(CAShapeLayer*)maskLayer{
    return objc_getAssociatedObject(self, &ltx_view_maskLayer);
}
-(void)setMaskLayer:(CAShapeLayer * _Nonnull)maskLayer{
    objc_setAssociatedObject(self, &ltx_view_maskLayer, maskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIBezierPath*)path{
    return objc_getAssociatedObject(self, &ltx_view_path);
}
-(void)setPath:(UIBezierPath * _Nonnull)path{
    objc_setAssociatedObject(self, &ltx_view_path, path, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
