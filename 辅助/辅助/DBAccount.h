//
//  DBAccount.h
//  辅助
//
//  Created by 赵硕 on 2016/11/15.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAccount : NSObject<NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;


@property (nonatomic, copy) NSString *encrytoken;


@property (nonatomic, copy) NSString *pay_token;


@property (nonatomic, copy) NSString *pfkey;


@property (nonatomic, assign)BOOL user_cancelled;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expirationDate;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *openId;
/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;
/** sdk  */
//@property (nonatomic,copy)NSString *sdkVersion;

+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
