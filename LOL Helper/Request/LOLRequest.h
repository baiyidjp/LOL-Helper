//
//  LOLRequest.h
//  LOL Helper
//
//  Created by tztddong on 16/10/10.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface LOLRequest : NSObject

//封装一个AFN的get请求
+ (void)getWithUrl:(NSString *)urlStr
            params:(NSDictionary *)params
           success:(void(^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)urlStr
             params:(NSDictionary *)params
            success:(void(^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

+ (AFHTTPSessionManager *)sharedInstance;

+ (void)cancelAllOperations;

@end
