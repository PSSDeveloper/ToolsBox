//
//  PGAuthorizationManager.h
//  AuthorTool
//
//  Created by 彭帅 on 2016/12/13.
//  Copyright © 2016年 彭帅. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum : NSUInteger {
//    1,
//    2,
//    3,
//} 1;
typedef NS_ENUM(NSInteger,PGAuthorizationType){
    PGAuthorizationTypeNone = 0,
    PGAuthorizationTypePush = 1 << 0,     /** 推送权限 */
    PGAuthorizationTypeAudio = 1 << 1,     /** 麦克风权限 */
    PGAuthorizationTypeCamera = 1 << 2,     /** 相机权限 */
    PGAuthorizationTypeLocation = 1 << 3,    /** 定位权限 */
    PGAuthorizationTypePhoto = 1 << 4,    /** 相册权限 */
    PGAuthorizationTypeContacts = 1 << 5    /** 通讯录权限 */
};


NS_CLASS_AVAILABLE_IOS(8_0)
@interface PGAuthorizationManager : NSObject
+ (PGAuthorizationType)obtainAuthorization;
+ (void)updateAuthrization;
@end
