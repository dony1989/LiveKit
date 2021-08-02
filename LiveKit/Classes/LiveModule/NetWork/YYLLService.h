//
//  YYLLService.h
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import <Foundation/Foundation.h>
#import "YYLLNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYLLService : NSObject

+(void)getLiveWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError * error))failure;

+(void)postLiveWithUrl:(NSString *)url params:(NSDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError * error))failure;


@end

NS_ASSUME_NONNULL_END
