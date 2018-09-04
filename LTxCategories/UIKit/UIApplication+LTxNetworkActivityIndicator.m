//
//  UIApplication+LTxNetworkActivityIndicator.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/4.
//

#import "UIApplication+LTxNetworkActivityIndicator.h"
#import <libkern/OSAtomic.h>
@implementation UIApplication (LTxNetworkActivityIndicator)

static volatile int32_t numberOfActiveNetworkConnectionsLTx;
- (void)ltx_beganNetworkActivity
{
    self.networkActivityIndicatorVisible = OSAtomicAdd32(1, &numberOfActiveNetworkConnectionsLTx) > 0;
}

- (void)ltx_endedNetworkActivity
{
    self.networkActivityIndicatorVisible = OSAtomicAdd32(-1, &numberOfActiveNetworkConnectionsLTx) > 0;
}

@end
