//
//  YLNetworkManager.h
//  YLNetworking-OC
//
//  Created by 包燕龙 on 2020/12/17.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void(^YLSuccessBlock)(id _Nullable responseObject);
typedef void(^YLFailureBlock)(NSError * _Nonnull error);
NS_ASSUME_NONNULL_BEGIN

@interface YLNetworkManager : NSObject
/// AFHTTPSessionManager
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/// 获取网络单例对象
+ (instancetype)shareInstance;


- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showLoading:(BOOL)showLoading;
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showLoading:(BOOL)showLoading;
@end

NS_ASSUME_NONNULL_END
