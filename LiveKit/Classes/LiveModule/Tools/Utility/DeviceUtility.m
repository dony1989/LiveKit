//
//  DeviceUtility.m
//  TeacherPi
//
//  Created by zhan on 15/5/4.
//  Copyright (c) 2015年 yimilan. All rights reserved.
//

#import "DeviceUtility.h"
#import <PhotosUI/PHPhotoLibrary+PhotosUISupport.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation DeviceUtility

#pragma mark camera utility
+ (void)isCameraAvailable:(void(^)(BOOL result))result {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    result(granted);
                });
            }
        }];
    } else if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)) {
        if (result) {
            result(NO);
        }
    }else {
        if (result) {
            result(YES);
        }
    }
}

+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL)isPhotoLibraryAvailable {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (BOOL)isWritePhotoLibraryAvailable {
    if (@available(iOS 14, *)) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelAddOnly];
        
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied ) {
            return NO;
        }else {
            return YES;
        }
        
    }else {
        
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized) {
            return YES;
        }
        if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
            return NO;
        }
        
        __block BOOL isAblity = YES;
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status != PHAuthorizationStatusAuthorized) {
                    NSLog(@"未开启相册权限,请到设置中开启");
                    isAblity = NO;
                }
                dispatch_semaphore_signal(semaphore);
            }];
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        return isAblity;
        
    }
}

+ (BOOL)isMicrophoneAvailable {
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if ((audioAuthStatus == AVAuthorizationStatusRestricted || audioAuthStatus ==AVAuthorizationStatusDenied)) {
        
        return NO;
        
    }else {
        return YES;
    }
}


+ (void)openCameraForDelegateVC:(id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)vc {
    if (!vc || ![vc isKindOfClass:[UIViewController class]] ) {
        return;
    }
    UIViewController *viewController = (UIViewController *)vc;
    [self isCameraAvailable:^(BOOL result) {
        if (result) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = vc;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [viewController presentViewController:controller
                                         animated:YES
                                       completion:^(void){
                NSLog(@"Picker View Controller is presented");
            }];
        } else {
            [self showPermissionsAlertWithType:DeviceUtilityPermissionsAlertTypeWithCamera viewController:viewController cancle:^{
                
            }];
     
        }
    }];
    
    
}

+ (void)showPermissionsAlertWithType:(DeviceUtilityPermissionsAlertType)type viewController:(UIViewController *)viewController cancle:(void(^)(void))cancle {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *tipMessage = @"获取相机权限失败，请前往系统设置中允许使用相机";
        if (type == DeviceUtilityPermissionsAlertTypeWithPhotoLibrary) {
            tipMessage = @"获取照片权限失败，请前往系统设置中允许使用照片";
        }else if (type == DeviceUtilityPermissionsAlertTypeWithMicrophone) {
            tipMessage = @"获取麦克风权限失败，请前往系统设置中允许使用麦克风";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:tipMessage preferredStyle:UIAlertControllerStyleAlert];

        
        UIAlertAction *action = ({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (cancle) {
                    cancle();
                }
            }];
            action;
        });
        
        UIAlertAction *ok = ({
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:appSettings];
                
            }];
            action;
        });
        
        [alert addAction:action];
        [alert addAction:ok];
        
        [viewController presentViewController:alert animated:YES completion:NULL];
    });
    
}

@end
