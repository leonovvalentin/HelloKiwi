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
    UINavigationController *NC = (UINavigationController *)self.window.rootViewController;
    NewsVC *VC = (NewsVC *)NC.topViewController;
    VC.APIHelper = [[APIHelperNews alloc] init];
    
    return YES;
}

@end
