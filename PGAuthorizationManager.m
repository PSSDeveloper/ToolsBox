//
//  PGAuthorizationManager.m
//  AuthorTool
//
//  Created by 彭帅 on 2016/12/13.
//  Copyright © 2016年 彭帅. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>
#import "PGAuthorizationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
static PGAuthorizationType KAuthorization;
@implementation PGAuthorizationManager

+ (void)initialize{
    KAuthorization = PGAuthorizationTypeNone;
    [self updateAuthrization];
}
+ (PGAuthorizationType)obtainAuthorization{
    return KAuthorization;
}
+ (void)updateAuthrization{
        /** 推送 */
    if ([[UIDevice currentDevice].systemVersion floatValue] < 10.f) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if ([UIApplication sharedApplication].currentUserNotificationSettings.types == UIUserNotificationTypeNone) {
            KAuthorization &= (~PGAuthorizationTypePush);
        }else{
            KAuthorization |= PGAuthorizationTypePush;
        }
 
    #pragma clang diagnostic pop
    }else{
        //兼容ios 10
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                KAuthorization |= PGAuthorizationTypePush;
            }else{
                KAuthorization &= (~PGAuthorizationTypePush);
            }
        }];
    }
        /** 麦克风 */
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (granted) {
            KAuthorization |= PGAuthorizationTypeAudio;
        }else{
            KAuthorization &= (~PGAuthorizationTypeAudio);
        }
    }];
        /** 相机 */
    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized) {
        KAuthorization |= PGAuthorizationTypeCamera;
    }else{
        KAuthorization &= (~PGAuthorizationTypeAudio);
    }
        /** 定位 */
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        KAuthorization |= PGAuthorizationTypeLocation;
    }else{
        KAuthorization &= (~PGAuthorizationTypeLocation);
    }
        /** 相册 */
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized) {
        KAuthorization |= PGAuthorizationTypePhoto;
    }else{
        KAuthorization &= (~PGAuthorizationTypePhoto);
    }
        /** 通讯录 */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
            KAuthorization |= PGAuthorizationTypeContacts;
        }else{
            KAuthorization &= (~PGAuthorizationTypeContacts);
        }
    }else{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized) {
                KAuthorization |= PGAuthorizationTypeContacts;
            }else{
                KAuthorization &= (~PGAuthorizationTypeContacts);
            }
        }
        #pragma clang diagnostic pop
    }
}
@end
