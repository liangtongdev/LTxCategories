//
//  UIView+LTxConstraint.m
//  LTxCategories
//
//  Created by liangtong on 2018/11/2.
//

#import "UIView+LTxConstraint.h"

@implementation UIView (LTxConstraint)

- (void)ltx_pinAllEdgesOfSubview:(UIView *)subview{
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self ltx_pinSubview:subview edgeInsets:edgeInsets];
}

- (void)ltx_pinSubview:(UIView *)subview edgeInsets:(UIEdgeInsets)edgeInsets{
    if (![subview.superview isEqual:self]) {
        [self addSubview:subview];
    }
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:edgeInsets.left];
    NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f constant:edgeInsets.right];
    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:edgeInsets.top];
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.f constant:edgeInsets.bottom];
    //激活
    [NSLayoutConstraint activateConstraints: @[leading,trailing,top,bottom]];
}

@end
