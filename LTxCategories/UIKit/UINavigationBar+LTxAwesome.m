//
//  UINavigationBar+LTxAwesome.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import "UINavigationBar+LTxAwesome.h"
#import <objc/runtime.h>
@implementation UINavigationBar (LTxAwesome)
NSString const *ltx_overlayKey = @"ltx_overlayKey";

- (void)ltx_setBackgroundColor:(UIColor *)backgroundColor{
    
    UIView* overlayerView = objc_getAssociatedObject(self, &ltx_overlayKey);
    if (!overlayerView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        overlayerView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        overlayerView.userInteractionEnabled = NO;
        overlayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:overlayerView atIndex:0];
        
        objc_setAssociatedObject(self, &ltx_overlayKey, overlayerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    overlayerView.backgroundColor = backgroundColor;
}

- (void)ltx_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)ltx_setElementsAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    //    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)ltx_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    UIView* overlayerView = objc_getAssociatedObject(self, &ltx_overlayKey);
    [overlayerView removeFromSuperview];
    overlayerView = nil;
}


@end
