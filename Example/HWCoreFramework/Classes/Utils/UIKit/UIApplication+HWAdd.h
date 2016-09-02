
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HWApplicationSystemSettingType) {
    HWApplicationSystemSettingWIFI,
    HWApplicationSystemSettingBluetooth,
    HWApplicationSystemSettingGeneral,
    HWApplicationSystemSettingAbout,
    HWApplicationSystemSettingLocation,
    HWApplicationSystemSettingNotification,
};

typedef NS_ENUM(NSUInteger, HWApplicationSystemPhoneType) {
    HWApplicationSystemPhoneCall,
    HWApplicationSystemPhoneSendMessage,
};

@interface UIApplication (HWAdd)

@property (nonatomic, readonly) NSURL    *hw_documentsURL;
@property (nonatomic, readonly) NSString *hw_documentsPath;

@property (nonatomic, readonly) NSURL    *hw_cachesURL;
@property (nonatomic, readonly) NSString *hw_cachesPath;

@property (nonatomic, readonly) NSURL    *hw_libraryURL;
@property (nonatomic, readonly) NSString *hw_libraryPath;

@property (nonatomic, readonly) NSString *hw_appBundleName;

@property (nonatomic, readonly) NSString *hw_appBundleID;

@property (nonatomic, readonly) NSString *hw_appVersion;

@property (nonatomic, readonly) NSString *hw_appBuildVersion;

/// Can jump to system setting page.
+ (BOOL)hw_canOpenSystemSettingOfType:(HWApplicationSystemSettingType)type;

/// Jump to system setting page.
+ (BOOL)hw_openSystemSettingOfType:(HWApplicationSystemSettingType)type;

/// Can do phone action.
+ (BOOL)hw_canDoPhoneActionOfType:(HWApplicationSystemPhoneType)type withPhoneNumber:(NSString *)numberString;

/// Do phone action.
+ (BOOL)hw_doPhoneActionOfType:(HWApplicationSystemPhoneType)type withPhoneNumber:(NSString *)numberString;

@end
