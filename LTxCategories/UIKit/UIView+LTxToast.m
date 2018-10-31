//
//  UIView+LTxToast.m
//  LTxCategories
//
//  Created by liangtong on 2018/10/31.
//

#import "UIView+LTxToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat LTXToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat LTXToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat LTXToastHorizontalPadding   = 10.0;
static const CGFloat LTXToastVerticalPadding     = 10.0;
static const CGFloat LTXToastCornerRadius        = 10.0;
static const CGFloat LTXToastOpacity             = 0.8;
static const CGFloat LTXToastFontSize            = 16.0;
static const CGFloat LTXToastMaxTitleLines       = 0;
static const CGFloat LTXToastMaxMessageLines     = 0;
static const NSTimeInterval LTXToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat LTXToastShadowOpacity       = 0.8;
static const CGFloat LTXToastShadowRadius        = 6.0;
static const CGSize  LTXToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    LTXToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval LTXToastDefaultDuration  = 3.0;

// image view size
static const CGFloat LTXToastImageViewWidth      = 80.0;
static const CGFloat LTXToastImageViewHeight     = 80.0;

// activity
static const CGFloat LTXToastActivityWidth       = 100.0;
static const CGFloat LTXToastActivityHeight      = 100.0;
static const NSString * LTXToastActivityDefaultPosition = @"center";

// interaction
static const BOOL LTXToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * LTXToastTimerKey         = @"LTXToastTimerKey";
static const NSString * LTXToastActivityViewKey  = @"LTXToastActivityViewKey";
static const NSString * LTXToastTapCallbackKey   = @"LTXToastTapCallbackKey";

// positions
NSString * const LTXToastPositionTop             = @"top";
NSString * const LTXToastPositionCenter          = @"center";
NSString * const LTXToastPositionBottom          = @"bottom";

@interface UIView (LTXToastPrivate)

- (void)ltx_hideToast:(UIView *)toast;
- (void)ltx_toastTimerDidFinish:(NSTimer *)timer;
- (void)ltx_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)ltx_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)ltx_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)ltx_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@implementation UIView (LTxToast)
#pragma mark - Toast Methods

- (void)ltx_makeToast:(NSString *)message {
    [self ltx_makeToast:message duration:LTXToastDefaultDuration position:nil];
}

- (void)ltx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(nullable id)position {
    UIView *toast = [self ltx_viewForMessage:message title:nil image:nil];
    [self ltx_showToast:toast duration:duration position:position];
}

- (void)ltx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self ltx_viewForMessage:message title:title image:nil];
    [self ltx_showToast:toast duration:duration position:position];
}

- (void)ltx_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self ltx_viewForMessage:message title:nil image:image];
    [self ltx_showToast:toast duration:duration position:position];
}

- (void)ltx_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self ltx_viewForMessage:message title:title image:image];
    [self ltx_showToast:toast duration:duration position:position];
}

- (void)ltx_showToast:(UIView *)toast {
    [self ltx_showToast:toast duration:LTXToastDefaultDuration position:nil];
}


- (void)ltx_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(nullable id)position {
    [self ltx_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)ltx_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
         tapCallback:(nullable void(^)(void))tapCallback
{
    toast.center = [self ltx_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (LTXToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(ltx_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:LTXToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(ltx_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &LTXToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &LTXToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)ltx_hideToast:(UIView *)toast {
    [UIView animateWithDuration:LTXToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)ltx_toastTimerDidFinish:(NSTimer *)timer {
    [self ltx_hideToast:(UIView *)timer.userInfo];
}

- (void)ltx_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &LTXToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &LTXToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self ltx_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)ltx_makeToastActivity {
    [self ltx_makeToastActivity:LTXToastActivityDefaultPosition];
}

- (void)ltx_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &LTXToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LTXToastActivityWidth, LTXToastActivityHeight)];
    activityView.center = [self ltx_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:LTXToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = LTXToastCornerRadius;
    
    if (LTXToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = LTXToastShadowOpacity;
        activityView.layer.shadowRadius = LTXToastShadowRadius;
        activityView.layer.shadowOffset = LTXToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &LTXToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:LTXToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)ltx_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &LTXToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:LTXToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &LTXToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)ltx_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:LTXToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + LTXToastVerticalPadding);
        } else if([point caseInsensitiveCompare:LTXToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - LTXToastVerticalPadding);
}

- (CGSize)ltx_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)ltx_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = LTXToastCornerRadius;
    
    if (LTXToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = LTXToastShadowOpacity;
        wrapperView.layer.shadowRadius = LTXToastShadowRadius;
        wrapperView.layer.shadowOffset = LTXToastShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:LTXToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(LTXToastHorizontalPadding, LTXToastVerticalPadding, LTXToastImageViewWidth, LTXToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = LTXToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = LTXToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:LTXToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * LTXToastMaxWidth) - imageWidth, self.bounds.size.height * LTXToastMaxHeight);
        CGSize expectedSizeTitle = [self ltx_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = LTXToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:LTXToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * LTXToastMaxWidth) - imageWidth, self.bounds.size.height * LTXToastMaxHeight);
        CGSize expectedSizeMessage = [self ltx_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = LTXToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + LTXToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + LTXToastHorizontalPadding;
        messageTop = titleTop + titleHeight + LTXToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (LTXToastHorizontalPadding * 2)), (longerLeft + longerWidth + LTXToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + LTXToastVerticalPadding), (imageHeight + (LTXToastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}
@end
