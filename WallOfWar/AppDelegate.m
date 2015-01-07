//
//  AppDelegate.m
//  WallOfWar
//
//  Created by Matthew S. Hill on 10/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "AppDelegate.h"
#import "DecoderViewController.h"
#import "AboutViewController.h"
#import "GalleryViewController.h"

@interface AppDelegate (){
    UITabBarController *tabBarController;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    tabBarController = [[UITabBarController alloc] init];
    UITabBar *tabBar = tabBarController.tabBar;
    DecoderViewController *vc1 = [[DecoderViewController alloc] init];
    vc1.title = @"Decoder";
    GalleryViewController *vc2 = [[GalleryViewController alloc] init];
    vc2.title = @"Gallery";
    AboutViewController *vc3 = [[AboutViewController alloc] init];
    vc3.title = @"About";
    [tabBar setBackgroundColor:[UIColor blackColor]];
    NSArray *controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    tabBarController.viewControllers = controllers;
    
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
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
