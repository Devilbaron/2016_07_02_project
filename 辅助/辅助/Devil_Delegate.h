//
//  Devil_Delegate.h
//  辅助
//
//  Created by 赵硕 on 2016/11/6.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QQShareDelegate <NSObject>

-(void)shareSuccssWithQQCode:(NSInteger)code;
@end

@interface Devil_Delegate : UIResponder<UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (weak  , nonatomic) id<QQShareDelegate> qqDelegate;

@end
