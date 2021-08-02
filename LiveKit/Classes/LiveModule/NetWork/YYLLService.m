//
//  YYLLService.m
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import "YYLLService.h"
#import "YYLLBaseResModel.h"
#import "YYLLNetWork.h"

@implementation YYLLService

+(void)getLiveWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError * error))failure{
    YYLLNetworkRequest *request = [[YYLLNetworkRequest alloc] initWithServer:YYLLServerURLGateway() urlPath:url params:params];
    [request startWithSuccess:^(YYLLBaseResModel * _Nonnull model) {
        if (success) {
            success(model.data);
        }
    } failure:^(NSInteger errorCode, NSString * _Nonnull errorInfo) {
        if (failure) {
            NSString *errorStr = errorInfo.length > 1 ? errorInfo : kAppServerRequestAbnormalError;
            NSError *error = [NSError errorWithDomain:errorStr code:errorCode userInfo:@{NSLocalizedDescriptionKey : errorInfo}];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}

+(void)postLiveWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError * error))failure{
    YYLLNetworkRequest *request = [[YYLLNetworkRequest alloc] initWithServer:YYLLServerURLGateway() urlPath:url params:params];
    [request startWithSuccess:^(YYLLBaseResModel * _Nonnull model) {
        if (success) {
            success(model.data);
        }
        
    } failure:^(NSInteger errorCode, NSString * _Nonnull errorInfo) {
        if (failure) {
            NSString *errorStr = errorInfo.length > 1 ? errorInfo : kAppServerRequestAbnormalError;
            NSError *error = [NSError errorWithDomain:errorStr code:errorCode userInfo:@{NSLocalizedDescriptionKey : errorInfo}];
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}

@end
