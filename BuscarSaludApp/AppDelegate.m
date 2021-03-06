//
//  AppDelegate.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/17/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "AppDelegate.h"
#import "MPColorTools.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.infoEngine = [[getInfoEngine alloc] initWithHostName:@"local.buscarsalud.com"];
    UIColor *navigationBarColor = [UIColor colorWithRGB:0x619b1b];
    UIColor *tabBarColor = [UIColor colorWithRGB:0xf4f8f0];
    UIColor *tabBarTextColor = [UIColor colorWithRGB:0x75a900];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"Load resources for iOS 6.1 or earlier");
    } else {
        NSLog(@"Load resources for iOS 7 or later");
        [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2.0f forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setBarTintColor:navigationBarColor];
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0], NSForegroundColorAttributeName,                                                               
                                                               [UIFont fontWithName:@"SourceSansPro-Regular" size:23], NSFontAttributeName, nil]];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SourceSansPro-Regular" size:12],NSFontAttributeName, nil] forState:UIControlStateNormal];
        //[[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0f, 0.0f)];
        [[UITabBar appearance] setBarTintColor:tabBarColor];
        [[UITabBar appearance] setTintColor:tabBarTextColor];
        
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
