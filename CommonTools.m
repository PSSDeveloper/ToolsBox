//
//  CommonTools.m
//  getFirstVC
//
//  Created by pengshuai on 16/6/21.
//  Copyright © 2016年 iningfeng. All rights reserved.
//

#import "CommonTools.h"

@implementation CommonTools

+ (UIViewController *)getCurrentVisiableController:(UIViewController *)VC{
    if ([VC isKindOfClass:[UINavigationController class]]) {
        //如果是导航控制器
        return [self getCurrentVisiableController:[(UINavigationController *)VC visibleViewController]];
    }else if([VC isKindOfClass:[UITabBarController class]]){
        //如果是TabBar控制器
        return [self getCurrentVisiableController:[(UITabBarController *)VC selectedViewController]];
    }else{
        //如果它有modal出的控制器,则继续递归遍历
        if (VC.presentedViewController) {
            return [self getCurrentVisiableController:VC.presentedViewController];
        }else{
            return VC;
        }
    }
}

/** 获取当前正在显示的控制器 */
+ (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tepWin in windows) {
            if (tepWin.windowLevel == UIWindowLevelNormal) {
                window = tepWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result;
}

@end
