//
//  UINavigationController+LTxAnimation.m
//  LTxCategories
//
//  Created by liangtong on 2019/2/23.
//

#import "UINavigationController+LTxAnimation.h"
#import <objc/runtime.h>

NSString const *ltx_navigate_animation = @"ltx_navigate_animation";

@implementation UINavigationController (LTxAnimation)
-(void)ltx_addAnimationWithType:(CATransitionType)type
                        subtype:(CATransitionSubtype)subtype
                 timingFunction:(CAMediaTimingFunctionName)timingFunction
                       duration:(CGFloat)duration{
    CATransition* animation = [self ltx_navigateAnimation];
    
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    animation.type = type;
    animation.subtype = subtype;
    
    [self.view.layer addAnimation:animation forKey:nil];
}



#pragma mark - Gerrer && Setter
-(CATransition*)ltx_navigateAnimation{
    CATransition* animation = objc_getAssociatedObject(self, &ltx_navigate_animation);
    if (!animation) {
        animation = [CATransition animation];
        objc_setAssociatedObject(self, &ltx_navigate_animation, animation, OBJC_ASSOCIATION_RETAIN);
    }
    return animation;
}
@end
