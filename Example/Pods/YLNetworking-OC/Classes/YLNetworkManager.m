//
//  YLNetworkManager.m
//  YLNetworking-OC
//
//  Created by 包燕龙 on 2020/12/17.
//

#import "YLNetworkManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

#ifdef DEBUG
#define YLLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
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
}

- (void)initialSVProgressHUDSetting
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
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
/// @param showLoading 是否展示提示
- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showLoading:(BOOL)showLoading
{
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,params);
    if (showLoading) {
        [SVProgressHUD show];
    }
    [self.manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        YLLog(@"response :%@===%@",url,response);
        if (showLoading) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
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
/// @param showLoading 是否展示提示
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showLoading:(BOOL)showLoading
{
    if (!url || [url isEqualToString:@""]) {
        YLLog(@"url不能为空");
        return;
    }
    YLLog(@"requst :%@=====%@",url,params);
    if (showLoading) {
        [SVProgressHUD show];
    }
    [self.manager GET:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        YLLog(@"response :%@===%@",url,response);
        if (showLoading) {
            [SVProgressHUD dismiss];
        }
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (showLoading) {
            [SVProgressHUD dismiss];
        }
        YLLog(@"error :%@===%@",url,error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
