
#import <UIKit/UIKit.h>

@interface UIDevice (HWAdd)

/// iOS系统版本
+ (double)hw_systemVersion;

@property (nonatomic, readonly) BOOL hw_isPad;

@property (nonatomic, readonly) BOOL hw_isSimulator;

@property (nonatomic, readonly) BOOL hw_canMakePhoneCalls;

/// e.g. "iPhone6,1" "iPad4,6"
@property (nonatomic, readonly) NSString *hw_machineModel;

/// e.g. "iPhone 5s" "iPad mini 2"
@property (nonatomic, readonly) NSString *hw_machineModelName;

/// 系统启动的时间
@property (nonatomic, readonly) NSDate *hw_systemStartupTime;

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t hw_diskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t hw_diskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t hw_diskSpaceUsed;

@end
