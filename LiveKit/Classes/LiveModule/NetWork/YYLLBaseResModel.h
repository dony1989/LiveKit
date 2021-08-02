//
//  YYLLBaseResModel.h
//  PrivateTest
//
//  Created by don on 2021/8/2.
//

#import <Foundation/Foundation.h>
#import "BaseHttpConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYLLBaseResModel : NSObject

@property (nonatomic, assign) YYLLServerCode code;

@property (nonatomic, strong, nullable) id data;

@property (nonatomic, copy  , nullable) NSString *msg;

@property (nonatomic, copy) NSString *timestamp;

@property (nonatomic, assign) NSInteger iTotalRecords;

@property (nonatomic, assign) NSInteger iTotalDisplayRecords;

@property (nonatomic, assign) NSInteger subCode;

@property (nonatomic, copy  , nullable) NSString *subMsg;

@property (nonatomic, strong, nullable) id body;

@end

NS_ASSUME_NONNULL_END
