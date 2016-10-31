//
//  UIImageView+LoadImage.m
//  JPLoopViewDemo
//
//  Created by tztddong on 2016/10/31.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "UIImageView+LoadImage.h"

@implementation UIImageView (LoadImage)

- (void)jp_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    self.image = placeholder;
    if (!url){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JPDownloadImageCache"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if(!isDirExist){
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!bCreateDir) {
            NSLog(@"创建文件出错");
            return;
        }
    }
    NSString *urlString = [url absoluteString];
    NSString *imageName = [[urlString componentsSeparatedByString:@"/"] lastObject];
    NSString *pathString = [[path stringByAppendingString:@"/"] stringByAppendingString:imageName];
    NSData *saveData = [NSData dataWithContentsOfFile:pathString];
    if (saveData) {
        UIImage *saveImage = [UIImage imageWithData:saveData];
        self.image = saveImage;
        return;
    }

    //创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建会话请求
    NSURLSessionDownloadTask *downTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        [fileManager moveItemAtURL:location toURL:[NSURL fileURLWithPath:pathString] error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSData *saveData = [NSData dataWithContentsOfFile:pathString];
            if (saveData) {
                UIImage *saveImage = [UIImage imageWithData:saveData];
                self.image = saveImage;
                return;
            }
        });
    }];
    //发送请求
    [downTask resume];
}

@end
