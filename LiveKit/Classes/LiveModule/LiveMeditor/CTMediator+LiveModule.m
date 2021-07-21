//
//  CTMediator+LiveModule.m
//  PrivateTest
//
//  Created by don on 2021/7/19.
//

#import "CTMediator+LiveModule.h"

NSString * const kLiveModuleTarget = @"LiveModule";
NSString * const kLiveModuleViewController = @"getLiveViewController";


@implementation CTMediator (LiveModule)
- (UIViewController *)CTMediator_LiveViewController
{
    UIViewController *viewController = [self performTarget:kLiveModuleTarget
                                                    action: kLiveModuleViewController
                                                    params:@{@"title":@"value"}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        return [[UIViewController alloc] init];
    }
}
@end
