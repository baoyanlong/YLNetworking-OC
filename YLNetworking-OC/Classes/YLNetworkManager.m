//
//  YLNetworkManager.m
//  YLNetworking-OC
//
//  Created by 包燕龙 on 2020/12/17.
//

#import "YLNetworkManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

#ifdef DEBUG
#define YLLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define YLLog(...)
#endif

@implementation YLNetworkManager

/// 获取网络单例对象
+ (instancetype)shareInstance
{
    static YLNetworkManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
        instance.manager = [AFHTTPSessionManager manager];
        [instance initialSettings];
        [instance initialSVProgressHUDSetting];
    });
    return instance;
}

- (void)initialSettings
{
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.manager.securityPolicy.allowInvalidCertificates = YES;
//    [self.manager.securityPolicy setValidatesDomainName:NO];
//    [self.manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    _manager.requestSerializer.timeoutInterval = 15.f;
    
//    // 无条件的信任服务器上的证书
//    AFSecurityPolicy *securityPolicy=[AFSecurityPolicy defaultPolicy];
//    // 客户端是否信任非法证书
//    securityPolicy.allowInvalidCertificates = NO;
//    // 是否在证书域字段中验证域名
//    securityPolicy.validatesDomainName = NO;
//    _manager.securityPolicy = securityPolicy;
}

- (void)initialSVProgressHUDSetting
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}

- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure
{
    [self postUrl:url params:params success:success failure:failure showHUD:NO];
}
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure
{
    [self getUrl:url params:params success:success failure:failure showHUD:NO];
}

// 请求之前调的方法
- (void)networkFrontOperations
{
    
}

/// post请求
/// @param url 请求地址
/// @param params 请求参数
/// @param failure 失败回调
/// @param success 成功回调
/// @param showHUD 是否展示提示
- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showHUD:(BOOL)showHUD
{
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,params);
    if (showHUD) {
        [SVProgressHUD show];
    }
    [self.manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        YLLog(@"response :%@===%@",url,response);
        if (showHUD) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showHUD) {
            [SVProgressHUD dismiss];
        }
        YLLog(@"error :%@===%@",url,error);
        if (failure) {
            failure(error);
        }
    }];
}


/// get请求
/// @param url 请求地址
/// @param params 请求参数
/// @param failure 失败回调
/// @param success 成功回调
/// @param showHUD 是否展示提示
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showHUD:(BOOL)showHUD
{
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,params);
    if (showHUD) {
        [SVProgressHUD show];
    }
    [self.manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        YLLog(@"response :%@===%@",url,response);
        if (showHUD) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showHUD) {
            [SVProgressHUD dismiss];
        }
        YLLog(@"error :%@===%@",url,error);
        if (failure) {
            failure(error);
        }
    }];
}


- (void)uploadWithImage:(NSData *)imageData
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(YLProgressBlock)progress
                              success:(YLSuccessBlock)success
                                 fail:(YLFailureBlock)fail
                              showHUD:(BOOL)showHUD{
    
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,params);
    
    if (showHUD==YES) {
        [SVProgressHUD show];
    }
    
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.timeoutInterval=30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];


    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        YLLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        YLLog(@"response :%@===%@",url,response);
        if (success) {
            success(response);
        }
//        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YLLog(@"error=%@",error);
        if (fail) {
            fail(error);
        }
        
//        [[self tasks] removeObject:sessionTask];
        
        if (showHUD==YES) {
            [SVProgressHUD dismiss];
        }
        
    }];
    
//    if (sessionTask) {
//        [[self tasks] addObject:sessionTask];
//    }
    
}

- (void)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(YLProgressBlock )progressBlock
                              success:(YLSuccessBlock )success
                              failure:(YLFailureBlock )fail
                              showHUD:(BOOL)showHUD{
    
    
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,saveToPath);
    
    if (showHUD==YES) {
        [SVProgressHUD show];
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    AFHTTPSessionManager *manager = [self getAFManager];

    
    NSURLSessionDownloadTask *sessionTask = [self.manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        YLLog(@"下载进度--%.1f",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            if (progressBlock) {
                progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!saveToPath) {
            
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            YLLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        }else{
            return [NSURL fileURLWithPath:saveToPath];
            
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        YLLog(@"下载文件成功");
        
//        [[self tasks] removeObject:sessionTask];
        
        if (error == nil) {
            if (success) {
                success([filePath path]);//返回完整路径
            }
            
        } else {
            if (fail) {
                fail(error);
            }
        }
        
        if (showHUD==YES) {
            [SVProgressHUD dismiss];
        }
        
    }];
    
    //开始启动任务
    [sessionTask resume];
//    if (sessionTask) {
//        [[self tasks] addObject:sessionTask];
//    }
    
}

@end
