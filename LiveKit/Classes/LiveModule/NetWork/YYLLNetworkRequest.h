//
//  YYLLNetworkRequest.h
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import <Foundation/Foundation.h>
#import "BaseHttpConfig.h"
#import "YYLLNetWork.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYLLNetworkRequest : NSObject
/**
 默认POST。
 */
@property (nonatomic, assign) YYLLNetworkRequestMethod method;

@property (nonatomic, copy) YYLLServerURL *server;

@property (nonatomic, copy) NSString *urlPath;

@property (nonatomic, copy, nullable) NSDictionary *params;

@property (nonatomic, copy, nullable) NSDictionary *headerFields;

@property (nonatomic, strong, nullable) NSData *HTTPBody;

@property (nonatomic, assign) BOOL needEncrypt;

/// logout等部分接口不需要处理-13的情况。
@property (nonatomic, assign) BOOL notNeedAutoRefreshToken;

/// 超时时间，默认10s。
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, copy, readonly) NSString *kRequestUniqueId;

/// 默认为AFHTTPRequestSerializer，若需要AFJSONRequestSerializer,请单独设置。
@property (nonatomic, strong, nullable) AFHTTPRequestSerializer *requestSerializer;

@property (nonatomic, strong, readonly) NSURLSessionTask *task;

@property (nonatomic, copy, nullable, readonly) YYLLNetworkSuccessBlock successBlock;
@property (nonatomic, copy, nullable, readonly) YYLLNetworkFailureBlock failureBlock;

+ (instancetype)requestWithServer:(YYLLServerURL *)server
                          urlPath:(NSString *)urlPath
                           params:(nullable NSDictionary *)params;

- (instancetype)initWithServer:(YYLLServerURL *)server
                       urlPath:(NSString *)urlPath
                        params:(nullable NSDictionary *)params NS_DESIGNATED_INITIALIZER;

- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;

- (void)startWithSuccess:(nullable YYLLNetworkSuccessBlock)success
                 failure:(nullable YYLLNetworkFailureBlock)failure;

- (void)cancel;
@end

NS_ASSUME_NONNULL_END
