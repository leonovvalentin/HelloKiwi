//
//  HelloKiwiTests.m
//  HelloKiwiTests
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import <Kiwi/Kiwi.h>



SPEC_BEGIN(NewsVCSpec)

describe(@"NewsVC", ^{
    
    __block NewsVC *sut;
    
    beforeEach(^{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil];
        UINavigationController *NC = [sb instantiateInitialViewController];
        sut = (NewsVC *)NC.topViewController;
        sut.APIHelper = [[APIHelperNews alloc] init];
        [sut view];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should ask APIHelper about news after viewWillAppear:", ^{
        [[sut.APIHelper should] receive:@selector(newsWithSuccess:failure:)];
        [sut viewWillAppear:NO];
    });
    
    context(@"tableView", ^{
        
        __block UITableView *tableView;
        
        beforeEach(^{
            tableView = sut.tableView;
        });
        
        it(@"should not be nil", ^{
            [[sut.tableView shouldNot] beNil];
        });
        
        it(@"should be top view", ^{
            [[sut.view.subviews[0] should] equal:sut.tableView];
        });
        
    });
    
});

SPEC_END
