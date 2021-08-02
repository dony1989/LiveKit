//
//  YYLLNetWork.h
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YYLLBaseResModel.h"

@class HYBaseResModel, YYLLNetworkRequest;

typedef enum : NSUInteger {
    YYLLNetworkRequestMethodPost = 0,
    YYLLNetworkRequestMethodGet
} YYLLNetworkRequestMethod;

typedef void(^YYLLNetworkSuccessBlock)(YYLLBaseResModel *model);
typedef void(^YYLLNetworkFailureBlock)(NSInteger errorCode, NSString *errorInfo);

typedef NSString YYLLServerURL;


@protocol YYLLNetworkDataSource <NSObject>
/// 必须实现  慎用  只在AppDelegate+networkMonitoring类中实现使用
@required
- (NSDictionary *)commonParams;
- (NSString *)gatewayAppkey;
- (NSString *)gatewayToken;
- (NSString *)cookieHeaderValue;
- (NSString *)requestToken;
- (NSString *)userId;
- (AFNetworkReachabilityStatus)networkState;

- (YYLLNetworkRequest *)refreshToken:(NSString *)oldToken
                       withSuccess:(YYLLNetworkSuccessBlock)success
                           failure:(YYLLNetworkFailureBlock)failure;

- (void)performLogoutWithHUDMsg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YYLLNetWork : NSObject
@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong, readonly) NSMutableDictionary *reloadRequests;

@property (nonatomic, weak) id<YYLLNetworkDataSource> dataSource;

+ (instancetype)sharedInstance;
- (YYLLNetworkRequest *)refreshToken:(NSString *)token;
- (void)addReloadRequest:(YYLLNetworkRequest *)request;

@end


@interface YYLLAFJSONResponseSerializer : AFJSONResponseSerializer

@end

FOUNDATION_EXPORT YYLLServerURL * const YYLLServerURLGateway(void);
FOUNDATION_EXPORT YYLLServerURL * const YYLLServerURLWxH5(void);

FOUNDATION_EXPORT NSInteger const kYYLLNetworkDefaultTimeout;
FOUNDATION_EXPORT NSInteger const kYYLLNetworkMainHomeTimeoutInterval;

NS_ASSUME_NONNULL_END
