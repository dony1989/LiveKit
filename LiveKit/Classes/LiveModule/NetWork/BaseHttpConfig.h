//
//  BaseHttpConfig.h
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#ifndef BaseHttpConfig_h
#define BaseHttpConfig_h

//CCActionBlock
typedef void (^LiveServiceSuccessWithDataBlock)(id data);
typedef void (^LiveServiceFailureWithCodeBlock)(NSInteger errorCode, NSString *errorInfo);


// ServerCode
typedef enum NSInteger {
    kServerCodeNotNetWork = -1009,
    kServerCodeInDarkHouse = -99,
    kServerCodeUseUnregisterToLoginCode = -20,
    kServerCodeRepeatedOperationCode = -100, //操作重复
    kServerCodeSessionError = -13,
    kServerCodeOldUser = -5,//已被注册
    kServerCodeLoginFromOtherDevice = -1,
    kServerCodeError = 0,
    kServerCodeSuccess = 1,
    kServerCodeNotNeedUpdate = 2
  
}YYLLServerCode;

static NSString *const APPConstant_responseCode        = @"code";
static NSString *const APPConstant_responseMsg         = @"msg";
static NSString *const APPConstant_responseData        = @"data";
static NSString *const APPConstant_responseTimestamp   = @"timestamp";
static NSString *const APPConstant_responseTotal       = @"total";


static NSString *const kOrderSignValue          =   @"signValue";

static NSString *const kSignHeader              =   @"X-GateWay-sv";

static NSString *const kSignVersionName         =   @"v2";
static NSString *const kSignVersionHeader       =   @"X-GateWay-ver";


static NSString *const kAppNetworkRequestNoNetworkMessage    =  @"网络已断开，请重试";
static NSString *const kAppServerRequestTimeoutIntervalError =  @"网络超时，请稍后重试~";
static NSString *const kAppServerRequestAbnormalError        =  @"服务器开小差啦，稍后再试！";

#endif /* BaseHttpConfig_h */
