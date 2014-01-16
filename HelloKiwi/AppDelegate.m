//
//  AppDelegate.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "ImagesVC.h"
#import "AppDelegate.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *newsNC = (UINavigationController *)tabBarController.viewControllers[0];
    NewsVC *newsVC = (NewsVC *)newsNC.topViewController;
    newsVC.APIHelper = [[APIHelperNews alloc] init];
    
    ImagesVC *imagesVC = (ImagesVC *)tabBarController.viewControllers[1];
    imagesVC.viewControllers = @[[[UIViewController alloc] init],
                                 [[UIViewController alloc] init],
                                 [[UIViewController alloc] init]];
    
    return YES;
}

@end
