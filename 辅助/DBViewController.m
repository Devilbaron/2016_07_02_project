//
//  DBViewController.m
//  辅助
//
//  Created by 赵硕 on 2016/11/15.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

#import "DBViewController.h"
#import "UIWindow+Extension.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentMessageObject.h>
#import "DBAccount.h"
#import "DBAccountTools.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DBViewController ()<TencentSessionDelegate>
@property(nonatomic,strong)TencentOAuth *tencentOAuth;
@property(nonatomic,retain)NSArray *permissions;
@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105703939" andDelegate:self];
    //_tencentOAuth.redirectURI = @"www.qq.com";
    
    //授权
    _permissions =  [NSArray arrayWithObjects:
                     kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     nil];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH/2-50, HEIGHT/2-75, 100, 50);
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"QQ授权" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal
     ];
    [self.view addSubview:button];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WIDTH/2-50, HEIGHT/2+25, 100, 50);
    [button addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"QQ登出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal
     ];
    [self.view addSubview:button];
    
}
- (IBAction)loginAction:(id)sender {
    
    
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setValue:[_tencentOAuth accessToken] forKey:@"access_token"];
        [dict setValue:[_tencentOAuth expirationDate] forKey:@"expirationDate"];
        [dict setValue:[_tencentOAuth openId] forKey:@"openId"];
        //[dict setValue:[_tencentOAuth.sdkVersion] forKey:@"sdkVersion"];
        DBAccount * Account = [DBAccount accountWithDict:dict];
        [DBAccountTools saveAccount:Account];
        #pragma mark 登录成功后，回调 - 返回对应QQ的相关信息
        /**
         * 获取用户个人信息回调
         * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
         * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
         *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
         */
        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        //- (void)getUserInfoResponse:(APIResponse*) response
        NSLog(@"授权成功,%@",[_tencentOAuth accessToken]);
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    }else{
        
        NSLog(@"accessToken 没有获取成功");
    }
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}


/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
 /*
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}
*///
/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
/*
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}
*/
/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
//- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
//    NSLog(@"增量授权完成");
//    if (tencentOAuth.accessToken
//        && 0 != [tencentOAuth.accessToken length])
//    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
//        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
//    }
//    else
//    {
//        NSLog(@"增量授权不成功，没有获取accesstoken");
//    }
//    
//}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
//- (void)tencentFailedUpdate:(UpdateFailType)reason{
//    
//    switch (reason)
//    {
//        case kUpdateFailNetwork:
//        {
//            //            _labelTitle.text=@"增量授权失败，无网络连接，请设置网络";
//            NSLog(@"增量授权失败，无网络连接，请设置网络");
//            break;
//        }
//        case kUpdateFailUserCancel:
//        {
//            //            _labelTitle.text=@"增量授权失败，用户取消授权";
//            NSLog(@"增量授权失败，用户取消授权");
//            break;
//        }
//        case kUpdateFailUnknown:
//        default:
//        {
//            NSLog(@"增量授权失败，未知错误");
//            break;
//        }
//    }
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
