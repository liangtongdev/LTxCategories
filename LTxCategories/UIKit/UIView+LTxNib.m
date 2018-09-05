//
//  UIView+LTxNib.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import "UIView+LTxNib.h"

@implementation UIView (LTxNib)
+ (UINib *)ltx_loadNib{
    return [self ltx_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)ltx_loadNibNamed:(NSString*)nibName{
    return [self ltx_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)ltx_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)ltx_loadInstanceFromNib{
    return [self ltx_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName{
    return [self ltx_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner{
    return [self ltx_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)ltx_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}
@end
