//
//  EncyptUtility.h
//  PrivateTest
//
//  Created by don on 2021/8/6.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonCryptor.h>

/**
 AES加密字符串。
 */
FOUNDATION_EXPORT NSString *YYLLEncryptStrByAES(NSString *str, NSString *key);
/**
 AES解密字符串。
 */
FOUNDATION_EXPORT NSString *YYLLDecryptStrByAES(NSString *str, NSString *key);
/**
 base64 data转string。
 */
FOUNDATION_EXPORT NSString *YYLLBase64StrWithData(NSData *data);
/**
 base64 string转data。
 */
FOUNDATION_EXPORT NSData *YYLLBase64DataWithStr(NSString *str);

//sha1 encode, 替换`BaseUtility sha1:`
FOUNDATION_EXPORT NSString *YYLLSha1Str(NSString *str);

//md5 encode 替换`BaseUtility md5:`
FOUNDATION_EXPORT NSString *YYLLMD5Str(NSString *str);

///  替换`BaseUtility hmacsha1:key:`
FOUNDATION_EXPORT NSString *YYLLHmacSha1Str(NSString *text, NSString *secret);


@interface EncyptUtility : NSObject

@end


