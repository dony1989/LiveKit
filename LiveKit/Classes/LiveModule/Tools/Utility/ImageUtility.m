//
//  ImageUtility.m
//  TeacherPi
//
//  Created by zhan on 15/5/4.
//  Copyright (c) 2015年 yimilan. All rights reserved.
//

#import "ImageUtility.h"
#import "UIImage+Ext.h"
#import <Accelerate/Accelerate.h>
@interface ImageUtility ()

@property (nonatomic, strong) dispatch_queue_t concurrentPhotoQueue; ///&lt; Add this

@end

@implementation ImageUtility

+ (instancetype)instance
{
    static ImageUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ImageUtility alloc] init];
        
        sharedInstance->_concurrentPhotoQueue = dispatch_queue_create("com.selander.GooglyPuff.photoQueue",
                                                                             DISPATCH_QUEUE_CONCURRENT);
    });
    return sharedInstance;
}

#pragma mark image scale utility
+ (UIImage *)imageByScalingToMaxSize:(float)maxSize withSourceImage:(UIImage *)sourceImage {
    if (sourceImage.size.width < maxSize) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = maxSize;
        btWidth = sourceImage.size.width * (maxSize / sourceImage.size.height);
    } else {
        btWidth = maxSize;
        btHeight = sourceImage.size.height * (maxSize / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 * 异步保存图片
 */
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName {
    return [self saveImage:tempImage WithName:imageName isSync:NO];
}

/**
 * 保存图片
 */
- (NSString *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName isSync:(BOOL)isSync{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    NSArray *nameAry=[fullPathToFile componentsSeparatedByString:@"/"];
    NSLog(@"===fullPathToFile===%@",fullPathToFile);
    NSLog(@"===FileName===%@",[nameAry objectAtIndex:[nameAry count]-1]);
    
    if (isSync) {
        NSData* imageData;
        
        //判断图片是不是png格式的文件
        if (UIImagePNGRepresentation(tempImage)) {
            //返回为png图像。
            imageData = UIImagePNGRepresentation(tempImage);
        }else {
            //返回为JPEG图像。
            imageData = UIImageJPEGRepresentation(tempImage, 1.0);
        }
        [imageData writeToFile:fullPathToFile atomically:NO];
    }
    else
    {
        //异步写入
        dispatch_barrier_async(self.concurrentPhotoQueue, ^{
            NSData* imageData;
            
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(tempImage)) {
                //返回为png图像。
                imageData = UIImagePNGRepresentation(tempImage);
            }else {
                //返回为JPEG图像。
                imageData = UIImageJPEGRepresentation(tempImage, 1.0);
            }
            [imageData writeToFile:fullPathToFile atomically:NO];
        });
    }
    
    return fullPathToFile;
}

-(UIImage *)getImageWithName:(NSString *)imageName
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    return [self getImageWithFullPath:fullPathToFile];
}

-(UIImage *)getImageWithFullPath:(NSString *)imagePath
{
    __block UIImage *image = nil;
    dispatch_sync(self.concurrentPhotoQueue, ^{
        image = [UIImage imageWithContentsOfFile:imagePath];
    });
    
    if (!image) {
        image = [UIImage imageNamed:@"default_image"];
    }
    return image;
}

-(void)removeImageWithFullPath:(NSString *)imagePath
{
    //异步写入
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //删掉原来的附件
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:&error];
    });
}

+(UIImage *)imageWithGaussianBlurFromImage:(UIImage *)img targetSize:(CGSize)targetSize {
    //还可以将已经渲染过的头像图片写到本地，下次直接读取即可。更换头像的时候先删除原来的，在保存新的即可。
    if (img == nil) return nil;
    UIImage *image = nil;
//    float factor = isIpad ? 6 : 1;
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    CIContext *context = nil;
    if (systemVersion >= 9.0) {
        context = [CIContext contextWithOptions:nil];

    }else {
        context = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(NO)}];

    }
    CGFloat blurValue = 10.0;
//    img = [img scaleToSize:CGSizeMake(img.size.width, img.size.width)];
    CIImage *inputImage = [CIImage imageWithCGImage:img.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:blurValue] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGRect extent = CGRectInset([inputImage extent],blurValue,blurValue);
    CGImageRef cgImage = [context createCGImage:result fromRect: extent];
    image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    // png之外的图片（jpg之类）用此方法会多一层红色，所以先统一转换成为png格式的图片，可优化，先判断不是png再转换
    NSData *imageData = UIImagePNGRepresentation(image);
    image = [UIImage imageWithData:imageData];
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    //按照旋转方向画图
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    //开启绘图上下文
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    //获取绘制的图片
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭绘图上下文
    UIGraphicsEndImageContext();
    
    return newPic;
}

+ (UIImage *)resizableImage:(NSString *)name
{
    UIImage *normal=[UIImage imageNamed:name];
    CGFloat w=normal.size.width*0.5;
    CGFloat h=normal.size.height*0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(w, h, w, h)];
}

@end
