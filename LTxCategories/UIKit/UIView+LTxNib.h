//
//  UIView+LTxNib.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (LTxNib)
+ (UINib *)ltx_loadNib;
+ (UINib *)ltx_loadNibNamed:(NSString*)nibName;
+ (UINib *)ltx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle;

+ (instancetype)ltx_loadInstanceFromNib;
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName;
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;
@end
