//
//  DBAccountTools.m
//  辅助
//
//  Created by 赵硕 on 2016/11/15.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

// 账号存储路径
#define DBAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


#import "DBAccount.h"
#import "DBAccountTools.h"

@implementation DBAccountTools
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(DBAccount *)account
{
    // 自定义对象的存储必须用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:DBAccountPath];
}


/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (DBAccount *)account
{
    
    // 加载模型
    DBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:DBAccountPath];
    
    /* 验证账号是否过期 */
    // 过期的秒数
    long long expirationDate = (long long)account.expirationDate;
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expirationDate];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}

@end
