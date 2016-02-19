//
//  UIImage+tailor.h
//  imageView
//
//  Created by pengshuai on 16/1/28.
//  Copyright © 2016年 iningfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (tailor)
/** 将图片放大/缩小到指定size */
- (UIImage *)scaleToSize:(CGSize)size;
/** 将图片按照所给区域以及是否以中心对称截取 */
- (UIImage *)getSubImageWithCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;
@end
