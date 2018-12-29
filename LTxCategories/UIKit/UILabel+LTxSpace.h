//
//  UILabel+LTxSpace.h
//  LTxCategories
//
//  Created by liangtong on 2018/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/***
 * UILabe 增加行间距
 ****/

@interface UILabel (LTxSpace)

//行间距
@property (nonatomic, assign) CGFloat ltx_lineSpace;

//字间距
@property (nonatomic, assign) CGFloat ltx_wordSpace;

@end

NS_ASSUME_NONNULL_END
