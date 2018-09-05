//
//  UIDevice+LTxHardware.m
//  LTxCategories
//
//  Created by liangtong on 2018/9/5.
//

#import "UIDevice+LTxHardware.h"
#include <sys/sysctl.h>
#import <sys/mount.h>
#import <mach/mach.h>

@implementation UIDevice (LTxHardware)
+ (NSString *)ltx_systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+ (BOOL)ltx_hasCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
#pragma mark - sysctl utils

+ (NSUInteger)ltx_getSysInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

#pragma mark - memory information
+ (NSUInteger)ltx_cpuFrequency {
    return [self ltx_getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)ltx_busFrequency {
    return [self ltx_getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ltx_ramSize {
    return [self ltx_getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)ltx_cpuNumber {
    return [self ltx_getSysInfo:HW_NCPU];
}


+ (NSUInteger)ltx_totalMemoryBytes
{
    return [self ltx_getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)ltx_freeMemoryBytes
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t pagesize;
    vm_statistics_data_t vm_stat;
    
    host_page_size(host_port, &pagesize);
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        return 0;
    }
    unsigned long mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

#pragma mark - disk information

+ (long long)ltx_freeDiskSpaceBytes
{
    struct statfs buf;
    long long freespace;
    freespace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        freespace = (long long)buf.f_bsize * buf.f_bfree;
    }
    return freespace;
}

+ (long long)ltx_totalDiskSpaceBytes
{
    struct statfs buf;
    long long totalspace;
    totalspace = 0;
    if ( statfs("/private/var", &buf) >= 0 ) {
        totalspace = (long long)buf.f_bsize * buf.f_blocks;
    }
    return totalspace;
}
@end
