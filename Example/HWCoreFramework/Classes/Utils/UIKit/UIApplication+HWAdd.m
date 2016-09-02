
#import "UIApplication+HWAdd.h"

@implementation UIApplication (HWAdd)

- (NSURL *)hw_documentsURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hw_documentsPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)hw_cachesURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hw_cachesPath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)hw_libraryURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hw_libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)hw_appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)hw_appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)hw_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)hw_appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

- (BOOL)hw_canOpenSystemSettingOfType:(HWApplicationSystemSettingType)type {
    return [self canOpenURL:[NSURL URLWithString:[self _systemSettingTypeStringForType:type]]];
}

- (BOOL)hw_openSystemSettingOfType:(HWApplicationSystemSettingType)type {
    return [self openURL:[NSURL URLWithString:[self _systemSettingTypeStringForType:type]]];
}

- (BOOL)hw_canDoPhoneActionOfType:(HWApplicationSystemPhoneType)type withPhoneNumber:(NSString *)numberString {
    return [self canOpenURL:[NSURL URLWithString:[self _systemPhoneTypeStringForType:type withPhoneNumber:numberString]]];
}

- (BOOL)hw_doPhoneActionOfType:(HWApplicationSystemPhoneType)type withPhoneNumber:(NSString *)numberString {
    return [self openURL:[NSURL URLWithString:[self _systemPhoneTypeStringForType:type withPhoneNumber:numberString]]];
}

- (NSString *)_systemSettingTypeStringForType:(HWApplicationSystemSettingType)type {
    switch (type) {
        case HWApplicationSystemSettingWIFI: return @"prefs:root=WIFI";
        case HWApplicationSystemSettingBluetooth: return @"prefs:root=Bluetooth";
        case HWApplicationSystemSettingGeneral: return @"prefs:root=General";
        case HWApplicationSystemSettingAbout: return @"prefs:root=General&path=About";
        case HWApplicationSystemSettingLocation: return @"prefs:root=LOCATION_SERVICES";
        case HWApplicationSystemSettingNotification: return @"prefs:root=NOTIFICATIONS_ID";
    }
}

- (NSString *)_systemPhoneTypeStringForType:(HWApplicationSystemPhoneType)type withPhoneNumber:(NSString *)numberString {
    switch (type) {
        case HWApplicationSystemPhoneCall: return [@"tel://" stringByAppendingString:numberString];
        case HWApplicationSystemPhoneSendMessage: return [@"sms://" stringByAppendingString:numberString];
    }
}

@end
