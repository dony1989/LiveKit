//
//  YYLLNetWork.m
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import "YYLLNetWork.h"
#import "YYLLAppConfig.h"
#import "YYLLNetworkRequest.h"
#import "LiveModuleCategoryHeader.h"

@interface YYLLNetWork ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) dispatch_queue_t sessionProcessingQueue;
@property (nonatomic, strong) dispatch_queue_t checkTokenQueue;
@property (nonatomic, strong) dispatch_semaphore_t addReloadRequestSema;
@property (nonatomic, weak  ) YYLLNetworkRequest *refreshTokenRequest;
@property (nonatomic, strong) NSMutableDictionary *reloadRequests;

@end

@implementation YYLLNetWork

+ (instancetype)sharedInstance {
    static YYLLNetWork *_kSharedHYNetwork = nil;
    static dispatch_once_t _kSharedHYNetworkOnceToken;
    dispatch_once(&_kSharedHYNetworkOnceToken, ^{
        _kSharedHYNetwork = [[YYLLNetWork alloc] init];
        _kSharedHYNetwork.checkTokenQueue = dispatch_queue_create("com.yyll.network.kCheckTokenQueue", DISPATCH_QUEUE_CONCURRENT);
        _kSharedHYNetwork.sessionProcessingQueue = dispatch_queue_create("com.yyll.network.kSessionProcessingQueue", DISPATCH_QUEUE_CONCURRENT);
        
        _kSharedHYNetwork.sessionManager = [AFHTTPSessionManager manager];
        _kSharedHYNetwork.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _kSharedHYNetwork.sessionManager.securityPolicy.validatesDomainName = NO;
        _kSharedHYNetwork.sessionManager.responseSerializer = [YYLLAFJSONResponseSerializer serializer];
        NSMutableSet * contentTypes = _kSharedHYNetwork.sessionManager.responseSerializer.acceptableContentTypes.mutableCopy;
        [contentTypes addObject:@"text/plain"];
        _kSharedHYNetwork.sessionManager.responseSerializer.acceptableContentTypes = contentTypes;
        _kSharedHYNetwork.sessionManager.completionQueue = _kSharedHYNetwork.sessionProcessingQueue;
        
        _kSharedHYNetwork.addReloadRequestSema = YYLLSemaCreate(0);
        _kSharedHYNetwork.reloadRequests = [NSMutableDictionary dictionary];
    });
    return _kSharedHYNetwork;
}

- (YYLLNetworkRequest *)refreshToken:(NSString *)token {
    if (self.refreshTokenRequest && self.refreshTokenRequest.task.state == NSURLSessionTaskStateRunning) {
        return self.refreshTokenRequest;
    }
    YYLLNetworkRequest *request = [[YYLLNetWork sharedInstance].dataSource refreshToken:token withSuccess:^(YYLLBaseResModel * _Nonnull model) {
        if (model.code == kServerCodeSuccess) {
            if (YYLLIsDictionaryNotEmpty(model.data)) {
                [self reloadcachedRequests];
            }
        }else {
            [self.reloadRequests removeAllObjects];
        }
    } failure:^(NSInteger errorCode, NSString * _Nonnull errorInfo) {
        [self.reloadRequests removeAllObjects];
    }];
    self.refreshTokenRequest = request;
    return request;
}

- (void)addReloadRequest:(YYLLNetworkRequest *)request {
    if (!request) {
        return;
    }
    dispatch_async(self.checkTokenQueue, ^{
        [self.reloadRequests setObjectSafe:request forKey:request.kRequestUniqueId];
        YYLLSemaSignal(self.addReloadRequestSema);
    });
    YYLLSemaWait(self.addReloadRequestSema, DISPATCH_TIME_FOREVER);
}

- (void)reloadcachedRequests {
    if (YYLLIsDictionaryNotEmpty(self.reloadRequests)) {
        [self.reloadRequests enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj && [obj isKindOfClass:[YYLLNetworkRequest class]]) {
                YYLLNetworkRequest *rReq = obj;
                NSMutableDictionary *param = [rReq.params mutableCopy];
                param[@"token"] = @"";
                rReq.params = param;
                [rReq startWithSuccess:[obj successBlock] failure:[obj failureBlock]];
                [self.reloadRequests removeObjectForKey:key];
            }
        }];
    }
}

@end

// MARK: YMLAFJSONResponseSerializer

@implementation YYLLAFJSONResponseSerializer

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (YYLLIsStringNotEmpty(dataString)) {
        *error = nil;
        return dataString;
    }
    return responseObject;
}
@end

// MARK: FOUNDATION_EXPORT 全局函数 & 变量
NSInteger const kYYLLNetworkDefaultTimeout = 10;
YYLLServerURL * const YYLLServerURLGateway(void) {
    return [NSString stringWithFormat:@"https://%@", @""];
}

YYLLServerURL * const YYLLServerURLWxH5(void) {
    return [NSString stringWithFormat:@"https://%@", @""];
}
