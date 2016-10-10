//
//  LOLRequest.m
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "LOLRequest.h"

static AFHTTPSessionManager *manager = nil;

@implementation LOLRequest

+ (AFHTTPSessionManager *)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
//        //支持https
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
//        // 设置可以接收无效的证书
//        [securityPolicy setAllowInvalidCertificates:YES];
//        manager.securityPolicy = securityPolicy;
        //超时
        manager.requestSerializer.timeoutInterval = 8;
    });
    return manager;
}
+ (void)cancelAllOperations{
    [manager.operationQueue cancelAllOperations];
}
/**
 *  get请求
 *
 *  @param urlStr  请求地址
 *  @param params  入参
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getWithUrl:(NSString *)urlStr
            params:(NSDictionary *)params
           success:(void(^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{
    
    [[self sharedInstance] GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}
/**
 *  post请求
 *
 *  @param urlStr  请求地址
 *  @param params  入参
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postWithUrl:(NSString *)urlStr
             params:(NSDictionary *)params
            success:(void(^)(id responseObject))success
            failure:(void (^)(NSError *error))failure
{
    [[self sharedInstance] POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}

@end
