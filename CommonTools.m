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
+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect =  CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 *  判断字符串是否为空
 *
 *  @param string 需要判断的字符串
 *
 *  @return
 */
+ (BOOL)isBlinkString:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}
/** 正则表达式匹配手机号码 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNum{
    if (phoneNum.length != 11) {
        return NO;
    }
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNum];
}

@end
