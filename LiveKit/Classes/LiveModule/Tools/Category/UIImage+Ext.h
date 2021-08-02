//
//  UIImage+Tint.h
//  ImageBlend
//
//  Created by wbitos on 13-4-29.
//  Copyright (c) 2013年 OneV-s-Den. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithTintColorHexString:(NSString *)tintColorHex;
- (UIImage *) imageWithGradientTintColorHexString:(NSString *)tintColorHex;
- (UIImage *) subImageInRect:(CGRect)rect;
- (UIImage *) scaleToSize:(CGSize)size;
- (UIImage *) imageScaleAspectFillFromTop:(CGSize)frameSize;
- (UIImage *) imageFillSize:(CGSize)viewsize;
- (UIImage *) scaleAndRotateImage;
- (UIImage *) scaleAndRotateImageMaxResolution:(CGFloat)resolution;

//旋转图片
- (UIImage *) rotateImage;

- (UIImage *) imageWithSize:(CGSize)size;
//将图片按给定的比例放大缩小
- (UIImage *) scaleImage:(float)scale;
- (UIImage *) subImageWithRect:(CGRect)rect;
+ (UIImage *) resizedImage:(NSString *)name;
+ (UIImage *) resizedImageWithImage:(UIImage *)image;


//生成带logol的二维码
+ (UIImage *) logolOrQRImage:(NSString *)QRTargetString logolImage:(NSString *)logolImage;

//截图
+ (UIImage *) snapshotViewFromRect:(CGRect)rect withCapInsets:(UIEdgeInsets)capInsets View:(UIView *)view;
+ (UIImage *) imageFromView:(UIView *)theView atFrame:(CGRect)rect;
+ (UIImage *) snashotForScrollView:(UIScrollView *)scrollView;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)fixOrientation;

- (UIImage *)rescaleImageToSize:(CGSize)size;

@end
