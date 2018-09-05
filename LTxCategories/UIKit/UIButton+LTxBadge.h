//
//  UIButton+LTxBadge.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

//  Created by Mike on 2014-05-05.
//  Copyright (c) 2014 Valnet Inc. All rights reserved.
//  https://github.com/mikeMTOL/UIBarButtonItem-Badge

#import <UIKit/UIKit.h>

@interface UIButton (LTxBadge)
@property (strong, nonatomic) UILabel *ltx_badge;

// Badge value to be display
@property (nonatomic) NSString *ltx_badgeValue;
// Badge background color
@property (nonatomic) UIColor *ltx_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *ltx_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *ltx_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat ltx_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat ltx_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat ltx_badgeOriginX;
@property (nonatomic) CGFloat ltx_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL ltx_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL ltx_shouldAnimateBadge;
@end
