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
    [self setUpTabBar];
    self.window.backgroundColor = [UIColor whiteColor];
    //custom status bar background
    UIView *statusBarView =  [[UIView alloc] initWithFrame:statusBarViewFrame];
    statusBarView.backgroundColor  =  statusBarColor;
    [self.window.rootViewController.view addSubview:statusBarView];
    
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

-(void)setUpTabBar{
    //set up tab bar
    tabBarController = [[UITabBarController alloc] init];
    
    DecoderViewController *vc1 = [[DecoderViewController alloc] init];
    UIImageView *i = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"decoder.png"]];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Decoder" image:i.image tag:0];
    
    GalleryViewController *vc2 = [[GalleryViewController alloc] init];
    UIImageView *g = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gallery.png"]];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Gallery" image:g.image tag:1];
    
    AboutViewController *vc3 = [[AboutViewController alloc] init];
    UIImageView *a = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about.png"]];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"About" image:a.image tag:2];
    
    NSArray *controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    tabBarController.viewControllers = controllers;
    [tabBarController.tabBar setBarTintColor:tabBarColor];
    [tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    self.window.rootViewController = tabBarController;
}
@end
