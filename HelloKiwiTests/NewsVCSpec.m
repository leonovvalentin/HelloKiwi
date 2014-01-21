//
//  HelloKiwiTests.m
//  HelloKiwiTests
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "NewsDetailVC.h"
#import "NewsCell.h"

#import "OHHTTPStubs+Tests.h"
#import "News+Tests.h"

#import <Kiwi/Kiwi.h>



SPEC_BEGIN(NewsVCSpec)

describe(@"NewsVC", ^{
    
    __block NewsVC *sut;
    
    beforeEach(^{
        sut = (NewsVC *)[[UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil]
                         instantiateViewControllerWithIdentifier:@"NewsVC"];
        sut.APIHelper = [[APIHelperNews alloc] init];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
    });
    
    afterEach(^{
        sut = nil;
        [MagicalRecord cleanUp];
    });
    
    it(@"should have right title", ^{
        [[sut.title should] equal:NSLocalizedString(@"NewsVCTitle", @"NewsVC title")];
    });
    
    context(@"after view was loaded", ^{
        
        beforeEach(^{
            [sut view];
        });
        
        it(@"should awake updateNews in viewWillAppear:", ^{
            [[sut should] receive:@selector(updateNews)];
            [sut viewWillAppear:NO];
        });
        
        it(@"should set stored news ordered by pubDate in viewWillAppear:", ^{
            
            NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
            
            News *news1 = [News MR_createInContext:context];
            news1.pubDate = [NSDate distantPast];
            
            News *news2 = [News MR_createInContext:context];
            news2.pubDate = [NSDate distantFuture];
            
            [context MR_saveOnlySelfAndWait];
            
            [sut viewWillAppear:NO];
            [[sut.news should] equal:@[news2, news1]];
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
        
        context(@"in prepareForSegue:sender: with NewsDetailVC as destination", ^{
            
            __block NewsDetailVC *detailVC;
            __block UIStoryboardSegue *segue;
            
            beforeEach(^{
                sut.news = @[[News testNews], [News anotherTestNews]];
                detailVC = [[NewsDetailVC alloc] init];
                segue = [UIStoryboardSegue segueWithIdentifier:nil
                                                        source:sut
                                                   destination:detailVC
                                                performHandler:^{}];
            });
            
            it(@"should send first news to destination VC if first cell was selected ", ^{
                   
                   [sut prepareForSegue:segue
                                 sender:[sut.tableView cellForRowAtIndexPath:
                                         [NSIndexPath indexPathForRow:0 inSection:0]]];
                   
                   [[detailVC.news should] equal:sut.news.firstObject];
               });
            
            it(@"should send second news to destination VC if second cell was selected ", ^{
                   
                   [sut prepareForSegue:segue
                                 sender:[sut.tableView cellForRowAtIndexPath:
                                         [NSIndexPath indexPathForRow:1 inSection:0]]];
                   
                   [[detailVC.news should] equal:sut.news.lastObject];
               });
        });
        
        it(@"should not crash if in prepareForSegue:sender: destination is not NewsDetailVC", ^{
            
            UIViewController *VC = [[UIViewController alloc] init];
            UIStoryboardSegue *segue = [UIStoryboardSegue segueWithIdentifier:nil
                                                                       source:sut
                                                                  destination:VC
                                                               performHandler:^{}];
            
            [[theBlock(^{
                [sut prepareForSegue:segue sender:nil];
            }) shouldNot] raise];
        });
        
        context(@"with success APIHelper", ^{
            
            beforeAll(^{
                [OHHTTPStubs setupSuccessResponseForAPIHelperNews];
            });
            
            afterAll(^{
                [OHHTTPStubs removeAllStubs];
            });
            
            it(@"should set right news ordered by pubDate in updateNews", ^{
                
                [APIHelperNews stub:@selector(newsFromSuccessResponse:)
                          andReturn:@[[News testNews], [News anotherTestNews]]];
                
                [sut updateNews];
                
                [[expectFutureValue(sut.news) shouldEventually] equal:
                 [News MR_findAllSortedBy:NSStringFromSelector(@selector(pubDate)) ascending:NO]];
            });
            
            it(@"should endRefreshing of refreshControl", ^{
                [[expectFutureValue(sut.refreshControl) shouldEventually] receive:
                 @selector(endRefreshing)];
                [sut updateNews];
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
                    newsItem = [News testNews];
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
