//
//  HelloKiwiTests.m
//  HelloKiwiTests
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "NewsCell.h"

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
    });
    
    afterEach(^{
        sut = nil;
    });
    
    context(@"after viewDidLoad", ^{
        
        beforeEach(^{
            [sut view];
        });
        
        it(@"should awake updateNews in viewWillAppear:", ^{
            [[sut should] receive:@selector(updateNews)];
            [sut viewWillAppear:NO];
        });
        
        it(@"should awake updateNews in after pullToRefresh", ^{
            NSArray *actions = 
            [sut.refreshControl actionsForTarget:sut forControlEvent:UIControlEventValueChanged];
            
            NSUInteger indx =
            [actions indexOfObjectPassingTest:^BOOL(NSString *obj, NSUInteger idx, BOOL *stop) {
                if ([obj isEqualToString:NSStringFromSelector(@selector(updateNews))]) {
                    *stop = YES;
                    return YES;
                }
                else {
                    return NO;
                }
            }];
            
            [[theValue(indx) shouldNot] equal:theValue(NSNotFound)];
        });
        
        it(@"should ask APIHelper about news in updateNews", ^{
            [[sut.APIHelper should] receive:@selector(newsWithSuccess:failure:)];
            [sut updateNews];
        });
        
        it(@"should have right title", ^{
            [[sut.title should] equal:NSLocalizedString(@"NewsVCTitle", @"NewsVC title")];
        });
        
        context(@"with success APIHelper", ^{
            
            beforeAll(^{
                [OHHTTPStubs setupSuccessResponseForAPIHelperNews];
            });
            
            afterAll(^{
                [OHHTTPStubs removeAllStubs];
            });
            
            it(@"should set right news in updateNews", ^{
                
                NSArray *news = @[[[News alloc] init]];
                [APIHelperNews stub:@selector(newsFromSuccessResponse:) andReturn:news];
                
                [sut updateNews];
                
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
            
            it(@"should have refreshView as subview", ^{
                [[tableView.subviews should] containObjectsInArray:@[sut.refreshControl]];
            });
            
            it(@"should reload data after setNews:", ^{
                [[sut.tableView should] receive:@selector(reloadData)];
                [sut setNews:nil];
            });
            
            context(@"with news", ^{
                
                __block News *newsItem;
                
                beforeEach(^{
                    
                    newsItem = [[News alloc] init];
                    newsItem.title = @"One news";
                    newsItem.link = @"http://one.news.com";
                    newsItem.descriptionOfNews = @"Ordinary news";
                    newsItem.pubDate = [NSDate date];
                    newsItem.guid = @"http://one.news.com/guid";
                    
                    sut.news = @[newsItem];
                });
                
                afterEach(^{
                    newsItem = nil;
                });
                
                it(@"should have 1 section", ^{
                    [[theValue([tableView numberOfSections]) should] equal:theValue(1)];
                });
                
                context(@"after reloadData", ^{
                    
                    beforeEach(^{
                        [tableView reloadData];
                    });
                    
                    it(@"should have right count of rows", ^{
                        [[theValue([tableView numberOfRowsInSection:0]) should] equal:
                         theValue([sut.news count])];
                    });
                    
                    it(@"should have NewsCell cells", ^{
                        NewsCell *cell = (NewsCell *)[tableView cellForRowAtIndexPath:
                                                      [NSIndexPath indexPathForRow:0 inSection:0]];
                        [[cell should] beKindOfClass:[NewsCell class]];
                    });
                    
                    it(@"should have right title for first cell", ^{
                        NewsCell *cell = (NewsCell *)[tableView cellForRowAtIndexPath:
                                                      [NSIndexPath indexPathForRow:0 inSection:0]];
                        [[cell.titleLabel.text should] equal:newsItem.title];
                    });
                    
                    it(@"should have right pub date for first cell", ^{
                        NewsCell *cell = (NewsCell *)[tableView cellForRowAtIndexPath:
                                                      [NSIndexPath indexPathForRow:0 inSection:0]];
                        [[cell.pubDateLabel.text should] equal:newsItem.pubDate.description];
                    });
                });
            });
        });
    });
});

SPEC_END
