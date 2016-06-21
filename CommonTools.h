//
//  CommonTools.h
//  getFirstVC
//
//  Created by pengshuai on 16/6/21.
//  Copyright © 2016年 iningfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTools : NSObject
/** 获取当前正在显示的控制器 */
+ (UIViewController *)getCurrentVisiableController:(UIViewController *)VC;

+ (UIViewController *)getCurrentVC;

/** 根据颜色来生成图片 */
+ (UIImage *)createImageWithColor:(UIColor *)color;
/** 判断一个字符是否为空字符串 */
+ (BOOL)isBlinkString:(NSString *)string;
/** 判断一串字符是否是合法的手机号码 */
+ (BOOL)isPhoneNumber:(NSString *)phoneNum;
@end
