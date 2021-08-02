//
//  ShadowUtility.h
//  Yuwen
//
//  Created by panyu_lt on 2017/7/5.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShadowUtility : NSObject

+ (void)setShadowForView:(UIView *)view withColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity offset:(CGSize)offset;

+ (void)setShadowForView:(UIView *)view withColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity;

+ (void)setShadowForView:(UIView *)view;
@end
