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
@end
