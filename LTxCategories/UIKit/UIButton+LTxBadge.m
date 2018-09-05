//
//  UIButton+LTxBadge.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import "UIButton+LTxBadge.h"
#import <objc/runtime.h>

NSString const *ltx_UIButton_badgeKey = @"ltx_UIButton_badgeKey";

NSString const *ltx_UIButton_badgeBGColorKey = @"ltx_UIButton_badgeBGColorKey";
NSString const *ltx_UIButton_badgeTextColorKey = @"ltx_UIButton_badgeTextColorKey";
NSString const *ltx_UIButton_badgeFontKey = @"ltx_UIButton_badgeFontKey";
NSString const *ltx_UIButton_badgePaddingKey = @"ltx_UIButton_badgePaddingKey";
NSString const *ltx_UIButton_badgeMinSizeKey = @"ltx_UIButton_badgeMinSizeKey";
NSString const *ltx_UIButton_badgeOriginXKey = @"ltx_UIButton_badgeOriginXKey";
NSString const *ltx_UIButton_badgeOriginYKey = @"ltx_UIButton_badgeOriginYKey";
NSString const *ltx_UIButton_shouldHideBadgeAtZeroKey = @"ltx_UIButton_shouldHideBadgeAtZeroKey";
NSString const *ltx_UIButton_shouldAnimateBadgeKey = @"ltx_UIButton_shouldAnimateBadgeKey";
NSString const *ltx_UIButton_badgeValueKey = @"ltx_UIButton_badgeValueKey";

@implementation UIButton (LTxBadge)

@dynamic ltx_badgeValue, ltx_badgeBGColor, ltx_badgeTextColor, ltx_badgeFont;
@dynamic ltx_badgePadding, ltx_badgeMinSize, ltx_badgeOriginX, ltx_badgeOriginY;
@dynamic ltx_shouldHideBadgeAtZero, ltx_shouldAnimateBadge;

- (void)ltx_badgeInit
{
    // Default design initialization
    self.ltx_badgeBGColor   = [UIColor redColor];
    self.ltx_badgeTextColor = [UIColor whiteColor];
    self.ltx_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.ltx_badgePadding   = 6;
    self.ltx_badgeMinSize   = 8;
    self.ltx_badgeOriginX   = self.frame.size.width - self.ltx_badge.frame.size.width/2;
    self.ltx_badgeOriginY   = -4;
    self.ltx_shouldHideBadgeAtZero = YES;
    self.ltx_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)ltx_refreshBadge
{
    // Change new attributes
    self.ltx_badge.textColor        = self.ltx_badgeTextColor;
    self.ltx_badge.backgroundColor  = self.ltx_badgeBGColor;
    self.ltx_badge.font             = self.ltx_badgeFont;
}

- (CGSize) ltx_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self ltx_duplicateLabel:self.ltx_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)ltx_updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self ltx_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.ltx_badgeMinSize) ? self.ltx_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.ltx_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.ltx_badge.frame = CGRectMake(self.ltx_badgeOriginX, self.ltx_badgeOriginY, minWidth + padding, minHeight + padding);
    self.ltx_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.ltx_badge.layer.masksToBounds = YES;
}

// Handle the badge changing value
- (void)ltx_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.ltx_shouldAnimateBadge && ![self.ltx_badge.text isEqualToString:self.ltx_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.ltx_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.ltx_badge.text = self.ltx_badgeValue;
    
    // Animate the size modification if needed
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self ltx_updateBadgeFrame];
    }];
}

- (UILabel *)ltx_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)ltx_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.ltx_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.ltx_badge removeFromSuperview];
        self.ltx_badge = nil;
    }];
}

#pragma mark - getters/setters
-(UILabel*)ltx_badge {
    return objc_getAssociatedObject(self, &ltx_UIButton_badgeKey);
}
-(void)setLtx_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &ltx_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
-(NSString *)ltx_badgeValue {
    return objc_getAssociatedObject(self, &ltx_UIButton_badgeValueKey);
}
-(void) setLtx_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &ltx_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.ltx_shouldHideBadgeAtZero)) {
        [self ltx_removeBadge];
    } else if (!self.ltx_badge) {
        // Create a new badge because not existing
        self.ltx_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.ltx_badgeOriginX, self.ltx_badgeOriginY, 20, 20)];
        self.ltx_badge.textColor            = self.ltx_badgeTextColor;
        self.ltx_badge.backgroundColor      = self.ltx_badgeBGColor;
        self.ltx_badge.font                 = self.ltx_badgeFont;
        self.ltx_badge.textAlignment        = NSTextAlignmentCenter;
        [self ltx_badgeInit];
        [self addSubview:self.ltx_badge];
        [self ltx_updateBadgeValueAnimated:NO];
    } else {
        [self ltx_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
-(UIColor *)ltx_badgeBGColor {
    return objc_getAssociatedObject(self, &ltx_UIButton_badgeBGColorKey);
}
-(void)setLtx_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &ltx_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_refreshBadge];
    }
}

// Badge text color
-(UIColor *)ltx_badgeTextColor {
    return objc_getAssociatedObject(self, &ltx_UIButton_badgeTextColorKey);
}
-(void)setLtx_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &ltx_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_refreshBadge];
    }
}

// Badge font
-(UIFont *)ltx_badgeFont {
    return objc_getAssociatedObject(self, &ltx_UIButton_badgeFontKey);
}
-(void)setLtx_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &ltx_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_refreshBadge];
    }
}

// Padding value for the badge
-(CGFloat) ltx_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_badgePaddingKey);
    return number.floatValue;
}
-(void) setLtx_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &ltx_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_updateBadgeFrame];
    }
}

// Minimum size badge to small
-(CGFloat) ltx_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
-(void) setLtx_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &ltx_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
-(CGFloat) ltx_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_badgeOriginXKey);
    return number.floatValue;
}
-(void) setLtx_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &ltx_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_updateBadgeFrame];
    }
}

-(CGFloat) ltx_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_badgeOriginYKey);
    return number.floatValue;
}
-(void) setLtx_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &ltx_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.ltx_badge) {
        [self ltx_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
-(BOOL) ltx_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setLtx_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &ltx_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
-(BOOL) ltx_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &ltx_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setLtx_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &ltx_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
