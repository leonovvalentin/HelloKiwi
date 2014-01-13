//
//  HelloKiwiTests.m
//  HelloKiwiTests
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "OHHTTPStubs+Tests.h"
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
    
    it(@"should ask APIHelper about news in viewWillAppear:", ^{
        [[sut.APIHelper should] receive:@selector(newsWithSuccess:failure:)];
        [sut viewWillAppear:NO];
    });
    
    context(@"with success APIHelper", ^{
        
        beforeAll(^{
            [OHHTTPStubs setupSuccessResponseForAPIHelperNews];
        });
        
        afterAll(^{
            [OHHTTPStubs removeAllStubs];
        });
        
        it(@"should set right news after viewWillAppear:", ^{
            
            NSArray *news = @[[[News alloc] init]];
            [APIHelperNews stub:@selector(newsFromSuccessResponse:) andReturn:news];
            
            [sut viewWillAppear:NO];
            
            [[expectFutureValue(sut.news) shouldEventually] equal:news];
        });
    });
    
    context(@"tableView", ^{
        
        __block UITableView *tableView;
        
        beforeEach(^{
            tableView = sut.tableView;
        });
        
        it(@"should not be nil", ^{
            [[tableView shouldNot] beNil];
        });
        
        it(@"should be top view", ^{
            [[sut.view.subviews[0] should] equal:tableView];
        });
        
        it(@"should have 1 section", ^{
            [[theValue([tableView numberOfSections]) should] equal:theValue(1)];
        });
        
        it(@"should have right count of rows", ^{
            sut.news = @[[[News alloc] init]];
            [[theValue([tableView numberOfRowsInSection:0]) should] equal:theValue(1)];
        });
    });
});

SPEC_END
