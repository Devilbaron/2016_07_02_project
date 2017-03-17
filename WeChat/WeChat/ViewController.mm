//
//  ViewController.m
//  WeChat
//
//  Created by 赵硕 on 16/7/29.
//  Copyright © 2016年 Devil baron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CPPClass cppClass;
    cppClass.CPPFunction("This is a C++ function!");
    CFunction("This is a C function!");
    ShortCFunction("This is a short C function!");
}

class CPPClass
{
public:
    void CPPFunction(const char *);
};
void CPPClass::CPPFunction(const char *arg0)
{
    for (int i = 0; i < 66; i++) // This for loop makes this function long enough to validate MSHookFunction
    {
        u_int32_t randomNumber;
        if (i % 3 == 0) randomNumber = arc4random_uniform(i);
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSArray *junks = @[hostName, globallyUniqueString, processName];
        NSString *junk = @"";
        for (int j = 0; j < pid; j++)
        {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (i % 68 == 1) NSLog(@"Junk: %@", junk);
    }
    NSLog(@"iOSRE: CPPFunction: %s", arg0);
}
extern "C" void CFunction(const char *arg0)
{
    for (int i = 0; i < 66; i++) // This for loop makes this function long enough to validate MSHookFunction
    {
        u_int32_t randomNumber;
        if (i % 3 == 0) randomNumber = arc4random_uniform(i);
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        NSString *hostName = processInfo.hostName;
        int pid = processInfo.processIdentifier;
        NSString *globallyUniqueString = processInfo.globallyUniqueString;
        NSString *processName = processInfo.processName;
        NSArray *junks = @[hostName, globallyUniqueString, processName];
        NSString *junk = @"";
        for (int j = 0; j < pid; j++)
        {
            if (pid % 6 == 0) junk = junks[j % 3];
        }
        if (i % 68 == 1) NSLog(@"Junk: %@", junk);
    }
    NSLog(@"iOSRE: CFunction: %s", arg0);
}
extern "C" void ShortCFunction(const char *arg0) // ShortCFunction is too short to be hooked
{
    CPPClass cppClass;
    cppClass.CPPFunction(arg0);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
