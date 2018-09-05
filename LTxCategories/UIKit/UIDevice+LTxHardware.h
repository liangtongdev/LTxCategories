//
//  UIDevice+LTxHardware.h
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

//  Created by Inder Kumar Rathore on 19/01/13.
//  Copyright (c) 2013 Rathore. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIDevice (LTxHardware)
//Return the current device CPU frequency
+ (NSUInteger)ltx_cpuFrequency;
// Return the current device BUS frequency
+ (NSUInteger)ltx_busFrequency;
//current device RAM size
+ (NSUInteger)ltx_ramSize;
//Return the current device CPU number
+ (NSUInteger)ltx_cpuNumber;
//Return the current device total memory

/// 获取iOS系统的版本号
+ (NSString *)ltx_systemVersion;
/// 判断当前系统是否有摄像头
+ (BOOL)ltx_hasCamera;
/// 获取手机内存总量, 返回的是字节数
+ (NSUInteger)ltx_totalMemoryBytes;
/// 获取手机可用内存, 返回的是字节数
+ (NSUInteger)ltx_freeMemoryBytes;

/// 获取手机硬盘空闲空间, 返回的是字节数
+ (long long)ltx_freeDiskSpaceBytes;
/// 获取手机硬盘总空间, 返回的是字节数
+ (long long)ltx_totalDiskSpaceBytes;
@end
