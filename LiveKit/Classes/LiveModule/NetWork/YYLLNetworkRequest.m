//
//  YYLLNetworkRequest.m
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import "YYLLNetworkRequest.h"
#import "YYLLAppConfig.h"
#import <MJExtension/MJExtension.h>
#import "EncyptUtility.h"
#import "LiveModuleHeader.h"

@interface YYLLNetworkRequest ()
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic, copy, nullable) NSString *requestToken;
@property (nonatomic, copy, nullable) YYLLNetworkSuccessBlock successBlock;
@property (nonatomic, copy, nullable) YYLLNetworkFailureBlock failureBlock;

@property (nonatomic, strong, nullable) NSMutableDictionary *mutableHeaderFields;


@property (nonatomic, copy) NSString *kRequestUniqueId;
@property (nonatomic, copy) NSString *secretKey;

@property (nonatomic, copy  ) NSDictionary *resultRequestParams;
@property (nonatomic, copy  ) NSDictionary *encryptResultRequestParams;

@end

@implementation YYLLNetworkRequest

- (void)dealloc {
//    NSLog(@"HYNetworkRequest dealloc: %@", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"HYNetworkRequest id:%@ \n- server: %@ \n- path: %@ \n- params: %@ \n- encryptResultRequestParams : %@ \n- headers: %@", self.kRequestUniqueId, self.server, self.urlPath, self.resultRequestParams,self.encryptResultRequestParams, self.headerFields];
}

// MARK: init request

- (instancetype)initWithServer:(YYLLServerURL *)server
                       urlPath:(NSString *)urlPath
                        params:(nullable NSDictionary *)params {
    if (![YYLLNetWork sharedInstance].dataSource) {
    }
    self = [super init];
    if (self) {
        self.server = server;
        self.urlPath = urlPath;
        self.params = params;
        self.mutableHeaderFields = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)init {
    return [self initWithServer:@"" urlPath:@"" params:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithServer:@"" urlPath:@"" params:nil];
}

+ (instancetype)requestWithServer:(YYLLServerURL *)server
                          urlPath:(NSString *)urlPath
                           params:(nullable NSDictionary *)params {
    return [[YYLLNetworkRequest alloc] initWithServer:server urlPath:urlPath params:params];
}

// MARK: start / cancel
- (void)startWithSuccess:(YYLLNetworkSuccessBlock)success
                 failure:(YYLLNetworkFailureBlock)failure {
    if (!YYLLIsStringNotEmpty(self.server) || !YYLLIsStringNotEmpty(self.urlPath)) {
        NSLog(@"HYNetworkRequest Error: server 或 urlPath为空");
        return;
    }
    self.successBlock = success;
    self.failureBlock = failure;
    self.requestToken = [[YYLLNetWork sharedInstance].dataSource requestToken];
    self.task = [self generateSessionTaskWithError:nil];
    [self.task resume];
}

- (void)cancel {
    self.successBlock = nil;
    self.failureBlock = nil;
    if (self.task && self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
    }
}

// MARK: requests generation
- (NSURLSessionTask *)generateSessionTaskWithError:(NSError * _Nullable __autoreleasing *)error {
    NSString *httpMethod = @"POST";
    if (self.method == YYLLNetworkRequestMethodGet) {
        httpMethod = @"GET";
    }
    NSString *url = [self generateCompeleteURL];
    if (self.timeoutInterval <= 0) {
        self.timeoutInterval = kYYLLNetworkDefaultTimeout;
    }
    if (!self.requestSerializer) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    self.requestSerializer.timeoutInterval = self.timeoutInterval;
    if (YYLLIsDictionaryNotEmpty(self.mutableHeaderFields)) {
        for (NSString *httpHeaderField in self.mutableHeaderFields.allKeys) {
            NSString *value = self.mutableHeaderFields[httpHeaderField];
            [self.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
    
    NSMutableURLRequest *request = nil;
    NSDictionary *params = [self generateParams];
    [self addCommonHeaderFieldsWithParams:params];
    request = [self.requestSerializer requestWithMethod:httpMethod URLString:url parameters:params error:error];
    if (self.HTTPBody) {
        request.HTTPBody = self.HTTPBody;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [[YYLLNetWork sharedInstance].sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *_error) {
        [self handleRequestResult:dataTask responseObject:responseObject error:_error];
    }];
    return dataTask;
}

- (NSString *)generateCompeleteURL {
    return [NSString stringWithFormat:@"%@%@", self.server, self.urlPath];
}

- (NSDictionary *)generateParams {
    /*
     app端所有请求中加入下面字段，配合server端用于米币商城区分安卓和iOS账号
     */
    NSMutableDictionary *newParams = [NSMutableDictionary dictionary];
    if (YYLLIsDictionaryNotEmpty(self.params)) {
        [newParams addEntriesFromDictionary:self.params];
    }
    if (YYLLIsDictionaryNotEmpty([[YYLLNetWork sharedInstance].dataSource commonParams])) {
        [newParams addEntriesFromDictionary:[[YYLLNetWork sharedInstance].dataSource commonParams]];
    }
    self.resultRequestParams = newParams.copy;
  
    return [newParams copy];
}

- (void)addCommonHeaderFieldsWithParams:(NSDictionary *)params {
    if (self.requestSerializer) {
        if ([self.server isEqualToString:YYLLServerURLGateway()]) {
            NSString *appkey = YYLLSafeString([[YYLLNetWork sharedInstance].dataSource gatewayAppkey]);
            [self.requestSerializer setValue:appkey forHTTPHeaderField:@"X-GateWay-appKey"];
            NSString *token = YYLLSafeString([[YYLLNetWork sharedInstance].dataSource gatewayToken]);//区分环境
            [self.requestSerializer setValue:token forHTTPHeaderField:@"X-GateWay-securityToken"];
        }
        [self.requestSerializer setValue:YYLLSafeString([[YYLLNetWork sharedInstance].dataSource cookieHeaderValue]) forHTTPHeaderField:@"Cookie"];
        [self.requestSerializer setValue:kSignVersionName forHTTPHeaderField:kSignVersionHeader];
        NSString *sha1Sign = [self getSHA1SignWithParams:params];
        [self.requestSerializer setValue:sha1Sign forHTTPHeaderField:kSignHeader];
    }
}

- (NSString *)getSHA1SignWithParams:(NSDictionary *)params {
    if (!YYLLIsDictionaryNotEmpty(params)) {
        return @"";
    }
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [params allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        [contentString appendFormat:@"%@=%@&", categoryId, [params objectForKey:categoryId]];
    }
//    [contentString appendFormat:@"%@", YYLLSafeString([[YYLLNetWork sharedInstance].dataSource ymlKey])];
    //去掉最后一个&  然后  得到MD5 sign签名
    //注意substringToIndex不包括参数的那个index的字符
    NSString *sha1Sign = [YYLLSha1Str([contentString substringToIndex:[contentString length]-1]) uppercaseString];
    return sha1Sign;
}

// MARK: hanle Data
/**
 统一处理接口返回请求。
 code == 1时，请求成功。
 code == -13时，将request添加到network reloadRequest内，在refresh token之后，再重新load request。
 code == -1时，用户被踢，退出登录。
 其他按请求失败处理。
 */
- (void)handleRequestResult:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error {
    if (error) {
        YYLLMainQueueAsync(^{
            NSLog(@"YYLLNetworkRequest result: %@ \n error: %@", self, error);
            [self handleError:error withModel:nil];
        });
        return;
    }
    NSLog(@"YYLLNetworkRequest result: %@ \n responseObj: %@", self, responseObject);
    YYLLBaseResModel *model = [YYLLBaseResModel mj_objectWithKeyValues:responseObject];
    YYLLMainQueueAsync(^{
        if (model.code == kServerCodeSuccess) {
            if (self.successBlock) {
                self.successBlock(model);
            }
            return;
        }
        if (model.code == kServerCodeLoginFromOtherDevice) {
            NSString *msg = YYLLIsStringNotEmpty(model.msg) ? YYLLSafeString(model.msg) : @"当前用户已经在其他设备登录，请新重登录";
            if (YYLLIsDictionaryNotEmpty([YYLLNetWork sharedInstance].reloadRequests)) {
                [[YYLLNetWork sharedInstance].reloadRequests removeAllObjects];
            }
            [[YYLLNetWork sharedInstance].dataSource performLogoutWithHUDMsg:msg];
            return;
        }
        if (model.code == kServerCodeSessionError) {
            if (!self.notNeedAutoRefreshToken) {
                [[YYLLNetWork sharedInstance] addReloadRequest:self];
                [[YYLLNetWork sharedInstance] refreshToken:self.requestToken];
            }
            return;
        }
        [self handleError:error withModel:model];
    });
}

- (void)handleError:(NSError *)error withModel:(YYLLBaseResModel *)model {
    NSInteger code = 0;
    if (error) {
        code = error.code;
    } else {
        if (self.failureBlock) {
            self.failureBlock(model.code, YYLLSafeString(model.msg));
        }
        self.successBlock = nil;
        self.failureBlock = nil;
        return;
    }
    if (self.failureBlock) {
        if ([[YYLLNetWork sharedInstance].dataSource networkState] == AFNetworkReachabilityStatusNotReachable) {
            error = [NSError errorWithDomain:kAppNetworkRequestNoNetworkMessage code:NSURLErrorNotConnectedToInternet userInfo:@{NSLocalizedDescriptionKey : kAppNetworkRequestNoNetworkMessage}];
        } else if (code == -1001) {
            error = [NSError errorWithDomain:kAppServerRequestTimeoutIntervalError code:code userInfo:@{NSLocalizedDescriptionKey : kAppServerRequestTimeoutIntervalError}];
        } else if (code == -1011) {
            NSDictionary *errorData = [[error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"] mj_JSONObject];
            int errorCode = [[errorData objectForKey:APPConstant_responseCode] intValue];
            if (errorCode == -101) {
                /// 您手机系统时间不正确，请设置正确时间后使用
                NSString *errorMsg = YYLLSafeString([errorData objectForKey:APPConstant_responseMsg]);
                error = [NSError errorWithDomain:errorMsg code:code userInfo:@{NSLocalizedDescriptionKey : errorMsg}];
            }else {
                error = [NSError errorWithDomain:kAppServerRequestAbnormalError code:code userInfo:@{NSLocalizedDescriptionKey : kAppServerRequestAbnormalError}];
            }
        } else {
            error = [NSError errorWithDomain:kAppServerRequestAbnormalError code:code userInfo:@{NSLocalizedDescriptionKey : kAppServerRequestAbnormalError}];
        }
        self.failureBlock(error.code, error.errorInfo);
    }
    self.successBlock = nil;
    self.failureBlock = nil;
}

- (NSDictionary *)parserJsonString:(NSString *)jsonStr {
    if (!YYLLIsStringNotEmpty(jsonStr)) {
        return nil;
    }
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData) {
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingAllowFragments
                                                              error:&err];
        if(err) {
            return nil;
        }
        return [dic copy];
    }
    return nil;
}

// MARK: setters
- (void)setHeaderFields:(NSDictionary *)headerFields {
    if (YYLLIsDictionaryNotEmpty(headerFields)) {
        [self.mutableHeaderFields addEntriesFromDictionary:headerFields];
    }
}

- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.mutableHeaderFields setValue:value forKey:field];
}

// MARK: getter
- (NSString *)kRequestUniqueId {
    if (!_kRequestUniqueId) {
        _kRequestUniqueId = [[NSUUID new] UUIDString];
    }
    return _kRequestUniqueId;
}

- (NSString *)secretKey {
    if (!_secretKey) {
        NSMutableString *secretKey = [NSMutableString string];
        for (int i = 0 ; i < 16; i++) {
            [secretKey appendString:@(rand()%10).stringValue];
        }
        _secretKey = [secretKey copy];
    }
    return _secretKey;
}

- (NSDictionary *)headerFields {
    return [self.mutableHeaderFields copy];
}

@end
