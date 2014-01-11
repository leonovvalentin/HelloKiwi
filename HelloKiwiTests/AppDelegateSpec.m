//
//  AppDelegateSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "AppDelegate.h"
#import "NewsVC.h"

#import <Kiwi/Kiwi.h>



SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    
    __block AppDelegate *sut;
    
    beforeEach(^{
        sut = [[AppDelegate alloc] init];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should set APIHelperNews for top VC after application:didFinishLaunchingWithOptions:", ^{
        
        sut.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        sut.window.rootViewController = [[UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil]
                                         instantiateInitialViewController];
        
        [sut application:nil didFinishLaunchingWithOptions:nil];
        
        UINavigationController *NC = (UINavigationController *)sut.window.rootViewController;
        NewsVC *VC = (NewsVC *)NC.topViewController;
        [[VC.APIHelper should] beKindOfClass:[APIHelperNews class]];
    });
    
});

SPEC_END
