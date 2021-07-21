//
//  Target_LiveModule.m
//  PrivateTest
//
//  Created by don on 2021/7/19.
//

#import "Target_LiveModule.h"
#import "LiveMainViewController.h"

@implementation Target_LiveModule

- (UIViewController *)Action_getLiveViewController:(NSDictionary *)params
{
    LiveMainViewController *viewController = [[LiveMainViewController alloc] init];
    viewController.dict = params;
    return viewController;
}
@end
