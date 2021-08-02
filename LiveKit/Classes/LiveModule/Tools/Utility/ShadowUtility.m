//
//  ShadowUtility.m
//  Yuwen
//
//  Created by panyu_lt on 2017/7/5.
//  Copyright © 2017年 yimilan. All rights reserved.
//

#import "ShadowUtility.h"
#import "YYLLAppConfig.h"

@implementation ShadowUtility

+ (void)setShadowForView:(UIView *)view withColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity offset:(CGSize)offset {
    view.layer.shadowColor = shadowColor.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

+ (void)setShadowForView:(UIView *)view withColor:(UIColor *)shadowColor shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    [self setShadowForView:view withColor:shadowColor shadowRadius:shadowRadius shadowOpacity:shadowOpacity offset:CGSizeMake(0, 0)];
}

+ (void)setShadowForView:(UIView *)view
{
    view.layer.shadowColor = YYLLHexColor(0xaeaeae).CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 4.0;
    view.layer.shadowOpacity = 0.2;
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}
@end
