//
//  NSObject+Base.h
//  PrivateTest
//
//  Created by don on 2021/7/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URL)

@property (nonatomic, copy, readonly, nullable) NSString *scheme;
@property (nonatomic, copy, readonly, nullable) NSString *host;
@property (nonatomic, copy, readonly, nullable) NSString *path;
@property (nonatomic, copy, readonly, nullable) NSString *query;
// query内解析后的参数，value经过URL decoding。
@property (nonatomic, copy, readonly, nullable) NSDictionary *queries;

@property (nonatomic, copy, readonly, nullable) NSString *kHYURLDecodingString;
@property (nonatomic, copy, readonly, nullable) NSString *kHYURLEncodingString;

@end

@interface NSError (Ext)
- (NSString *)errorInfo;
@end

NS_ASSUME_NONNULL_END
