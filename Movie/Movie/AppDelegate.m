//
//  AppDelegate.m
//  Movie
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 zhuge. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "LaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    
    //获取沙盒中保存的flag的值
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"kFirstStartFLag"];
    
    if (flag) {
        self.window.rootViewController = [[BaseTabBarController alloc] init];
        //测试用
        //[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kFirstStartFLag"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        self.window.rootViewController = [[LaunchViewController alloc] init];
        //在沙盒当中的plist文件当中添加一个kFirstStartFLag，并且设置其值
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kFirstStartFLag"];
        //每次对沙盒设置完成之后都需要同步
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
