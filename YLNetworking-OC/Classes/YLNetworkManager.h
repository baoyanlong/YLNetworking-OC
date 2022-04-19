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
typedef void(^YLProgressBlock)(int64_t bytesProgress, int64_t totalBytesProgress);
NS_ASSUME_NONNULL_BEGIN

@interface YLNetworkManager : NSObject
/// AFHTTPSessionManager
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/// 获取网络单例对象
+ (instancetype)shareInstance;

- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure;
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure;

- (void)postUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showHUD:(BOOL)showHUD;
- (void)getUrl:(NSString *)url params:(nullable NSMutableDictionary *)params success:(YLSuccessBlock)success failure:(YLFailureBlock)failure showHUD:(BOOL)showHUD;


/**
 *  上传图片方法
 *
 *  @param imageData      上传的图片
 *  @param url        请求连接，根路径
 *  @param filename   图片的名称(如果不传则以当时间命名)
 *  @param name       上传图片时填写的图片对应的参数
 *  @param params     参数
 *  @param progress   上传进度
 *  @param success    请求成功返回数据
 *  @param fail       请求失败
 *  @param showHUD    是否显示HUD
 */
- (void)uploadWithImage:(NSData *)imageData
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                               params:(NSDictionary *)params
                             progress:(YLProgressBlock)progress
                              success:(YLSuccessBlock)success
                                 fail:(YLFailureBlock)fail
                              showHUD:(BOOL)showHUD;

/**
 *  下载文件方法
 *
 *  @param url           下载地址
 *  @param saveToPath    文件保存的路径,如果不传则保存到Documents目录下，以文件本来的名字命名
 *  @param progressBlock 下载进度回调
 *  @param success       下载完成
 *  @param fail          失败
 *  @param showHUD       是否显示HUD
 *  @return 返回请求任务对象，便于操作
 */
- (void)downloadWithUrl:(NSString *)url
                           saveToPath:(NSString *)saveToPath
                             progress:(YLProgressBlock )progressBlock
                              success:(YLSuccessBlock )success
                              failure:(YLFailureBlock )fail
                              showHUD:(BOOL)showHUD;
@end

NS_ASSUME_NONNULL_END
