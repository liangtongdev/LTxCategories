//
//  UIButton+LTxLoading.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import "UIButton+LTxLoading.h"
#import <objc/runtime.h>

static void *LTxLoaderButtonTextAssociationKey = &LTxLoaderButtonTextAssociationKey;//Button上的字体
static void *LTxLoaderButtonIndicatorViewAssociationKey = &LTxLoaderButtonIndicatorViewAssociationKey;//UIActivityIndicatorView


@implementation UIButton (LTxLoading)

/**
 * 显示
 **/
- (void)ltx_startAnimating{
    [self ltx_stopAnimating];
    
    //存储文本
    NSString *currentButtonText = self.titleLabel.text;
    objc_setAssociatedObject(self, &LTxLoaderButtonTextAssociationKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //UIActivityIndicatorView
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    objc_setAssociatedObject(self, &LTxLoaderButtonIndicatorViewAssociationKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
    [indicator startAnimating];
}

/**
 * 隐藏
 **/
- (void)ltx_stopAnimating{
    NSString *textToRestore = (NSString *)objc_getAssociatedObject(self, &LTxLoaderButtonTextAssociationKey);
    UIActivityIndicatorView *indicatorToRestore = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &LTxLoaderButtonIndicatorViewAssociationKey);
    
    [indicatorToRestore removeFromSuperview];
    [self setTitle:textToRestore forState:UIControlStateNormal];
    self.enabled = YES;
    
    
    objc_setAssociatedObject(self, LTxLoaderButtonTextAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, LTxLoaderButtonIndicatorViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
