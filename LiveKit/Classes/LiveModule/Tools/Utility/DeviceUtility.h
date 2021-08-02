//
//  DeviceUtility.h
//  TeacherPi
//
//  Created by zhan on 15/5/4.
//  Copyright (c) 2015年 yimilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DeviceUtilityPermissionsAlertType) {
    DeviceUtilityPermissionsAlertTypeWithCamera = 0,
    DeviceUtilityPermissionsAlertTypeWithPhotoLibrary,
    DeviceUtilityPermissionsAlertTypeWithMicrophone
};
@interface DeviceUtility : NSObject

#pragma mark camera utility
+ (void)isCameraAvailable:(void(^)(BOOL result))result;
+ (BOOL)isPhotoLibraryAvailable;

+ (BOOL)isWritePhotoLibraryAvailable;
+ (BOOL)isMicrophoneAvailable;

+ (void)openCameraForDelegateVC:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)vc;

+ (void)showPermissionsAlertWithType:(DeviceUtilityPermissionsAlertType)type viewController:(UIViewController *)viewController cancle:(void(^)(void))cancle;

@end
