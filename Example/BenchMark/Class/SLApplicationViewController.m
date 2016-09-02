//
//  SLApplicationViewController.m
//  HWCoreFramework
//
//  Created by 58 on 9/2/16.
//  Copyright © 2016 ParallelWorld. All rights reserved.
//

#import "SLApplicationViewController.h"
#import "HWCoreFramework.h"

@interface SLApplicationViewController ()

@end

@implementation SLApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jumpToBluetooth:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingBluetooth]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingBluetooth];
    }
}
- (IBAction)jumpToWIFI:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingWIFI]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingWIFI];
    }
}

- (IBAction)jumpToGeneral:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingGeneral]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingGeneral];
    }
}

- (IBAction)jumpToAbout:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingAbout]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingAbout];
    }
}

- (IBAction)jumpToLocation:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingLocation]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingLocation];
    }
}

- (IBAction)jumpToNotification:(id)sender {
    if ([[UIApplication sharedApplication] hw_canOpenSystemSettingOfType:HWApplicationSystemSettingNotification]) {
        [[UIApplication sharedApplication] hw_openSystemSettingOfType:HWApplicationSystemSettingNotification];
    }
}

- (IBAction)call:(id)sender {
    if ([[UIApplication sharedApplication] hw_canDoPhoneActionOfType:HWApplicationSystemPhoneCall withPhoneNumber:@"1234567890"]) {
        [[UIApplication sharedApplication] hw_doPhoneActionOfType:HWApplicationSystemPhoneCall withPhoneNumber:@"1234567890"];
    }
}

- (IBAction)sendMessage:(id)sender {
    if ([[UIApplication sharedApplication] hw_canDoPhoneActionOfType:HWApplicationSystemPhoneSendMessage withPhoneNumber:@"1234567890"]) {
        [[UIApplication sharedApplication] hw_doPhoneActionOfType:HWApplicationSystemPhoneSendMessage withPhoneNumber:@"1234567890"];
    }
}

@end
