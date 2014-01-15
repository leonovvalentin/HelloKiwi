//
//  AppDelegate.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "AppDelegate.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *NC = (UINavigationController *)tabBarController.viewControllers[0];
    NewsVC *VC = (NewsVC *)NC.topViewController;
    VC.APIHelper = [[APIHelperNews alloc] init];
    
    return YES;
}

@end
