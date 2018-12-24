//
//  LTxCorner.h
//  LTxCategories
//
//  Created by liangtong on 2018/12/24.
//

#import <Foundation/Foundation.h>

/***
 * 工具类，圆角相关
 ***/

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, LTxCornerType) {
    LTxCornerTopLeft     = 1 << 1,
    LTxCornerTopRight    = 1 << 2,
    LTxCornerBottomLeft  = 1 << 3,
    LTxCornerBottomRight = 1 << 4,
    LTxCornerAll  = LTxCornerTopLeft | LTxCornerTopRight | LTxCornerBottomLeft | LTxCornerBottomRight
};

@interface LTxCorner : NSObject

/**
 * 给特定的path添加圆角轮廓点
 **/
+(void)addCornerWithPath:(UIBezierPath*)path cornerRadius:(CGFloat)cornerRadius cornerType:(LTxCornerType)cornerType size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
