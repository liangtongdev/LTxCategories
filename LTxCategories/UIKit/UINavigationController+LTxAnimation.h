//
//  UINavigationController+LTxAnimation.h
//  LTxCategories
//
//  Created by liangtong on 2019/2/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 导航的push/pop动画
 */
@interface UINavigationController (LTxAnimation)




/**
 给导航栏Push/Pop添加过渡动画

 @param type 过渡效果。可选值包括：kCATransitionFade（淡化） | kCATransitionMoveIn（覆盖） | kCATransitionPush（push） | kCATransitionReveal（揭开） | @"cameraIrisHollowOpen"（开镜头） | @"cameraIrisHollowClose"（关镜头） | @"cube"（3D立方） | @"suckEffect"（吮吸） | @"oglFlip"（翻转） | @"rippleEffect"（波纹） | @"pageCurl"（翻页） | @"pageUnCurl"（反翻页）
 @param subtype 控制动画方向。可选值包括：kCATransitionFromRight | kCATransitionFromLeft | kCATransitionFromTop | kCATransitionFromBottom
 @param timingFunction 动画：kCAMediaTimingFunctionLinear | kCAMediaTimingFunctionEaseIn | kCAMediaTimingFunctionEaseOut | kCAMediaTimingFunctionEaseInEaseOut | kCAMediaTimingFunctionDefault
 @param duration 动画时长
 */
-(void)ltx_addAnimationWithType:(CATransitionType)type
                        subtype:(CATransitionSubtype)subtype
                 timingFunction:(CAMediaTimingFunctionName)timingFunction
                       duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
