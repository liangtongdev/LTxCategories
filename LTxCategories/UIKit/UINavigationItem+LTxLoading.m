//
//  UINavigationItem+LTxLoading.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/4.
//

#import "UINavigationItem+LTxLoading.h"
#import <objc/runtime.h>

static void *LTxLoaderPositionAssociationKey = &LTxLoaderPositionAssociationKey;//展示位置
static void *LTxSubstitutedViewAssociationKey = &LTxSubstitutedViewAssociationKey;//现场数据

@implementation UINavigationItem (LTxLoading)

- (void)ltx_startAnimatingAt:(LTxNaviBarLoaderPosition)position {
    // stop previous if animated
    [self ltx_stopAnimating];
    
    // hold reference for position to stop at the right place
    objc_setAssociatedObject(self, LTxLoaderPositionAssociationKey, @(position), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIActivityIndicatorView* loader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // substitute bar views to loader and hold reference to them for restoration
    switch (position) {
        case LTxNaviBarLoaderPositionLeft:
            objc_setAssociatedObject(self, LTxSubstitutedViewAssociationKey, self.leftBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.leftBarButtonItem.customView = loader;
            break;
            
        case LTxNaviBarLoaderPositionCenter:
            objc_setAssociatedObject(self, LTxSubstitutedViewAssociationKey, self.titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.titleView = loader;
            break;
            
        case LTxNaviBarLoaderPositionRight:
            objc_setAssociatedObject(self, LTxSubstitutedViewAssociationKey, self.rightBarButtonItem.customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.rightBarButtonItem.customView = loader;
            break;
    }
    
    [loader startAnimating];
}

- (void)ltx_stopAnimating {
    NSNumber* positionToRestore = objc_getAssociatedObject(self, LTxLoaderPositionAssociationKey);
    id componentToRestore = objc_getAssociatedObject(self, LTxSubstitutedViewAssociationKey);
    
    // restore UI if animation was in a progress
    if (positionToRestore) {
        switch (positionToRestore.intValue) {
            case LTxNaviBarLoaderPositionLeft:
                self.leftBarButtonItem.customView = componentToRestore;
                break;
                
            case LTxNaviBarLoaderPositionCenter:
                self.titleView = componentToRestore;
                break;
                
            case LTxNaviBarLoaderPositionRight:
                self.rightBarButtonItem.customView = componentToRestore;
                break;
        }
    }
    
    objc_setAssociatedObject(self, LTxLoaderPositionAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, LTxSubstitutedViewAssociationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
