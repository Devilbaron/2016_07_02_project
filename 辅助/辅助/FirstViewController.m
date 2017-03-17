//
//  FirstViewController.m
//  辅助
//
//  Created by 赵硕 on 2016/10/25.
//  Copyright © 2016年 Devil_baron. All rights reserved.
//

#import "FirstViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface FirstViewController ()<TencentSessionDelegate>
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * btu = [UIButton buttonWithType:UIButtonTypeCustom];
    btu.frame = CGRectMake(WIDTH/2-50, HEIGHT/2-25, 100, 50);
    [btu setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btu setTitle:@"退出QQ登录" forState:UIControlStateNormal];
    [btu addTarget:self action:@selector(QQLogout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btu];
    
}
-(void)QQLogout:(UIButton*)btn{
    
}



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
