//
//  DBAccount.m
//  辅助
//
//  Created by 赵硕 on 2016/11/15.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

#import "DBAccount.h"
#import <TencentOpenAPI/TencentOAuth.h>
@implementation DBAccount
+(instancetype)accountWithDict:(NSDictionary *)dict{
    DBAccount * account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.encrytoken = dict[@"encrytoken"];
    account.pay_token = dict[@"pay_token"];
    account.user_cancelled = dict[@"user_cancelled"];
    account.pfkey = dict[@"pfkey"];
    account.openId = dict[@"openId"];
    account.expirationDate = dict[@"expirationDate"];
    // 获得账号存储的时间（accessToken的产生时间）
    account.created_time = [NSDate date];
    return account;
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.openId forKey:@"openId"];
    [aCoder encodeObject:self.expirationDate forKey:@"expirationDate"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
//    [aCoder encodeObject:self.sdkVersion forKey:@"sdkVersion"];
    
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.openId = [aDecoder decodeObjectForKey:@"openId"];
        self.expirationDate = [aDecoder decodeObjectForKey:@"expirationDate"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
//        self.sdkVersion = [aDecoder decodeObjectForKey:@"sdkVersion"];
        
    }
    
    return self;
}

@end
