//
//  EncyptUtility.m
//  PrivateTest
//
//  Created by don on 2021/8/6.
//

#import "EncyptUtility.h"

#import "YYLLAppConfig.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>


static NSString *const kYYLLRequestParamEncryptKey = @"zHzdfJkk6*7cj9Vu"; // 就是请求参数中的p

NSData *YYLLAESCrypt(NSData *data, NSString *key, CCOperation operation) {
    if (!YYLLIsStringNotEmpty(key) || !data) {
        return nil;
    }
    NSMutableData *keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    size_t dataMoved;
    int size = kCCBlockSizeAES128;
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length + size];
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    CCCryptorStatus result = CCCrypt(operation,                    // kCCEncrypt or kCCDecrypt
                                     kCCAlgorithmAES128,
                                     option,                        // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     NULL,
                                     data.bytes,
                                     data.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

NSString *YYLLEncryptStrByAES(NSString *str, NSString *key) {
    if (!YYLLIsStringNotEmpty(str) || !YYLLIsStringNotEmpty(key)) {
        return nil;
    }
    NSString *encryptStr = [NSString stringWithFormat:@"%@&sk=%@",str,key];
    NSData *dataEncrypt  =  YYLLAESCrypt([encryptStr dataUsingEncoding:NSUTF8StringEncoding], kYYLLRequestParamEncryptKey, kCCEncrypt);
    return YYLLBase64StrWithData(dataEncrypt);
}

NSString *YYLLDecryptStrByAES(NSString *str, NSString *key) {
    if (!YYLLIsStringNotEmpty(str) || !YYLLIsStringNotEmpty(key)) {
        return nil;
    }
    NSData *data = YYLLBase64DataWithStr(str);
    NSData *dataDecrypt = YYLLAESCrypt(data, key, kCCDecrypt);
    if (dataDecrypt) {
        NSString *decrypt = [[NSString alloc] initWithData:dataDecrypt encoding:NSUTF8StringEncoding];
        return decrypt;
    }
    return nil;
}

NSString *YYLLBase64StrWithData(NSData *data) {
    if (data) {
        NSString *base64String = [data base64EncodedStringWithOptions:0];
        return base64String;
    }
    return nil;
}

NSData *YYLLBase64DataWithStr(NSString *str) {
    if (YYLLIsStringNotEmpty(str)) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
        return data;
    }
    return nil;
}

//sha1 encode, 替换`BaseUtility sha1:`
NSString *YYLLSha1Str(NSString *str) {
    if (!YYLLIsStringNotEmpty(str)) {
        return nil;
    }
    NSData *data = [YYLLSafeString(str) dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

//md5 encode 替换`BaseUtility md5:`
NSString *YYLLMD5Str(NSString *str) {
    if (!YYLLIsStringNotEmpty(str)) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    return output;
}
///  替换`BaseUtility hmacsha1:key:`
NSString *YYLLHmacSha1Str(NSString *text, NSString *secret) {
    if (!YYLLIsStringNotEmpty(text) || !YYLLIsStringNotEmpty(secret)) {
        return nil;
    }
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    return [[NSData dataWithBytes:result length:20] base64EncodedStringWithOptions:0];
}

@implementation EncyptUtility

@end
