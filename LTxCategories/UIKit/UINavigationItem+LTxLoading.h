//
//  UINavigationItem+LTxLoading.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/4.
//

// Copyright (c) 2015 Anton Gaenko
// https://github.com/Just-/UINavigationItem-Loading

#import <UIKit/UIKit.h>
/**
 * 导航栏上显示UIActivityIndicatorView
 * 利用runtime机制，将相关数据进行关联，用以恢复现场
 **/

//展示位置
typedef NS_ENUM(NSUInteger, LTxNaviBarLoaderPosition){
    LTxNaviBarLoaderPositionCenter,//中间位置
    LTxNaviBarLoaderPositionLeft,//左侧
    LTxNaviBarLoaderPositionRight//右侧
};

@interface UINavigationItem (LTxLoading)

/**
 * 显示
 **/
- (void)ltx_startAnimatingAt:(LTxNaviBarLoaderPosition)position;

/**
 * 隐藏
 **/
- (void)ltx_stopAnimating;
@end
