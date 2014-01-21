//
//  AppDelegateSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "AppDelegate.h"
#import "NewsVC.h"
#import "ImagesVC.h"

#import <Kiwi/Kiwi.h>



SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    
    __block AppDelegate *sut;
    __block UITabBarController *tabBarController;
    
    beforeEach(^{
        sut = [[AppDelegate alloc] init];
        sut.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sut.window.rootViewController = [[UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil]
                                         instantiateInitialViewController];
        tabBarController = (UITabBarController *)sut.window.rootViewController;
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should setup MagicalRecord when application:didFinishLaunchingWithOptions:", ^{
        [[MagicalRecord should] receive:@selector(setupCoreDataStackWithStoreNamed:)
                          withArguments:@"Model.sqlite"];
        [sut application:nil didFinishLaunchingWithOptions:nil];
    });
    
    context(@"after application:didFinishLaunchingWithOptions:", ^{
        
        beforeEach(^{
            [sut application:nil didFinishLaunchingWithOptions:nil];
        });
        
        it(@"should set APIHelperNews for news VC after application:didFinishLaunchingWithOptions:", ^{
            UINavigationController *newsNC = (UINavigationController *)tabBarController.viewControllers[0];
            NewsVC *newsVC = (NewsVC *)newsNC.topViewController;
            [[newsVC.APIHelper should] beKindOfClass:[APIHelperNews class]];
        });
        
        it(@"should set viewControllers for images VC", ^{
            ImagesVC *imagesVC = (ImagesVC *)tabBarController.viewControllers[1];
            [[imagesVC.viewControllers shouldNot] beNil];
        });
    });
});

SPEC_END
