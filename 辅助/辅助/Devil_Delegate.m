//
//  Devil_Delegate.m
//  辅助
//
//  Created by 赵硕 on 2016/11/6.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "DBViewController.h"
#import "UIWindow+Extension.h"
#import "Devil_Delegate.h"
#import "DBAccount.h"
#import "DBAccountTools.h"

#define TENCENT_CONNECT_APP_KEY @"1105703939"

@interface Devil_Delegate ()<QQApiInterfaceDelegate,TencentSessionDelegate>

@end

@implementation Devil_Delegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    DBAccount *account = [DBAccountTools account];
    [self.window makeKeyAndVisible];
    
    if (account) {
        [self.window switchRootViewController];
    }else{
        self.window.rootViewController = [[DBViewController alloc]init];
    }
    [self.window makeKeyAndVisible];
    return YES;
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    /**
     处理由手Q唤起的跳转请求
     \param url 待处理的url跳转请求
     \param delegate 第三方应用用于处理来至QQ请求及响应的委托对象
     \return 跳转请求处理结果，YES表示成功处理，NO表示不支持的请求协议或处理失败
     */
    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"tencent%@",TENCENT_CONNECT_APP_KEY]]) {
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
        
    }
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    /**
//     处理由手Q唤起的跳转请求
//     \param url 待处理的url跳转请求
//     \param delegate 第三方应用用于处理来至QQ请求及响应的委托对象
//     \return 跳转请求处理结果，YES表示成功处理，NO表示不支持的请求协议或处理失败
//     */
//    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"tencent%@",TENCENT_CONNECT_APP_KEY]]) {
//        [QQApiInterface handleOpenURL:url delegate:self];
//        return [TencentOAuth HandleOpenURL:url];
//        
//    }
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
//    /**
//     处理由手Q唤起的跳转请求
//     \param url 待处理的url跳转请求
//     \param delegate 第三方应用用于处理来至QQ请求及响应的委托对象
//     \return 跳转请求处理结果，YES表示成功处理，NO表示不支持的请求协议或处理失败
//     */
//    if ([url.absoluteString hasPrefix:[NSString stringWithFormat:@"tencent%@",TENCENT_CONNECT_APP_KEY]]) {
//        [QQApiInterface handleOpenURL:url delegate:self];
//        return [TencentOAuth HandleOpenURL:url];
//    }
//    return YES;
//}
/**
 处理来至QQ的请求
 */
//- (void)onReq:(QQBaseReq *)req{
//    NSLog(@" ----req %@",req);
//}

/**
 处理来至QQ的响应
// */
//- (void)onResp:(QQBaseResp *)resp{
//    NSLog(@" ----resp %@",resp);
//    
//    // SendMessageToQQResp应答帮助类
//    if ([resp.class isSubclassOfClass: [SendMessageToQQResp class]]) {  //QQ分享回应
//        if (_qqDelegate) {
//            if ([_qqDelegate respondsToSelector:@selector(shareSuccssWithQQCode:)]) {
//                SendMessageToQQResp *msg = (SendMessageToQQResp *)resp;
//                NSLog(@"code %@  errorDescription %@  infoType %@",resp.result,resp.errorDescription,resp.extendInfo);
//                [_qqDelegate shareSuccssWithQQCode:[msg.result integerValue]];
//            }
//        }
//    }
//}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

@end
