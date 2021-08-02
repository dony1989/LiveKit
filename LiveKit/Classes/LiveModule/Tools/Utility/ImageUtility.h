//
//  ImageUtility.h
//  TeacherPi
//
//  Created by zhan on 15/5/4.
//  Copyright (c) 2015年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtility : NSObject

+ (instancetype)instance;

//裁切图像到指定的大小
+ (UIImage *)imageByScalingToMaxSize:(float)maxSize withSourceImage:(UIImage *)sourceImage;

//保存图片
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

//异步保存图片
- (UIImage *)getImageWithName:(NSString *)imageName;

//保存图片
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName isSync:(BOOL)isSync;

//保存图片
- (UIImage *)getImageWithFullPath:(NSString *)imagePath;

//异步删除图片
-(void)removeImageWithFullPath:(NSString *)imagePath;

//生成高斯模糊图片
+(UIImage *)imageWithGaussianBlurFromImage:(UIImage *)img targetSize:(CGSize)targetSize;
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;


//旋转图片
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

/**
  *  返回一张可以任意拉伸不变形的图片
  *
  */
+ (UIImage *)resizableImage:(NSString *)name;

@end
