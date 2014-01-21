//
//  APIHelperNewsSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"

#import "OHHTTPStubs+Tests.h"

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>



SPEC_BEGIN(APIHelperNewsSpec)

describe(@"APIHelperNews", ^{
    
    __block APIHelperNews *sut;
    
    beforeEach(^{
        sut = [[APIHelperNews alloc] init];
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
    });
    
    afterEach(^{
        sut = nil;
        [MagicalRecord cleanUp];
    });
    
    context(@"newsFromSuccessResponse:", ^{
        
        __block NSArray *news;
        
        beforeEach(^{
            news =
            [[sut class] newsFromSuccessResponse:
             [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"newsResponse.rss", nil)]];
        });
        
        afterEach(^{
            news = nil;
        });
        
        it(@"should return right news", ^{
            
            News *newsItem = news.firstObject;
            
            [[theValue([newsItem.title isEqualToString:
                        @"Прокуратура возбудила дело об избиении Юрия Луценко"]) should] beYes];
            
            [[theValue([newsItem.link isEqualToString:
                        @"http://news.yandex.ru/yandsearch?cl4url=www.rg.ru%2F2014%2F01%2F11%2Fluzenko-site-anons.html"]) should] beYes];
            
            [[theValue([newsItem.descriptionOfNews isEqualToString:
                        @"&quot;В отношении применения силы к оппозиции и получения телесных повреждений Юрием Луценко на проспекте Перемоги 109 прокуратура Киева начала криминальное расследование по статье превышение служебных полномочий&quot;, - информировала Соболевская."]) should] beYes];
            
            [[theValue([newsItem.guid isEqualToString:
                        @"http://news.yandex.ru/yandsearch?cl4url=www.rg.ru%2F2014%2F01%2F11%2Fluzenko-site-anons.html"]) should] beYes];
            
            [[theValue([newsItem.pubDate isEqualToDate:
                        [NSDate dateFromString:@"11 Jan 2014 12:47:00 +0400"]]) should] beYes];
        });
        
        it(@"should save context after parse news", ^{
            [[[News MR_findAll] should] containObjectsInArray:news];
        });
    });
    
    context(@"when success server response", ^{
        
        beforeAll(^{
            [OHHTTPStubs setupSuccessResponseForAPIHelperNews];
        });
        
        afterAll(^{
            [OHHTTPStubs removeAllStubs];
        });
        
        it(@"should go to success block after getting news", ^{
            
            __block BOOL success = NO;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 success = YES;
             }
             failure:nil];
            
            [[expectFutureValue(theValue(success)) shouldEventually] beYes];
        });
        
        it(@"should return news equals to news from newsFromSuccessResponse: in success block", ^{
            
            NSArray *rightNews =
            @[[News MR_createInContext: [NSManagedObjectContext MR_contextForCurrentThread]]];
            
            [[sut class] stub:@selector(newsFromSuccessResponse:) andReturn:rightNews];
            
            __block NSArray *newsFromResponse;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 newsFromResponse = news;
             }
             failure:nil];
            
            [[expectFutureValue(newsFromResponse) shouldEventually] equal:rightNews];
        });
    });
    
    context(@"when failed server request", ^{
        
        NSError *responseError = [NSError errorWithDomain:@"TestDomain" code:0 userInfo:nil];
        
        beforeAll(^{
            [OHHTTPStubs setupFailedResponseForAPIHelperNewsWithError:responseError];
        });
        
        afterAll(^{
            [OHHTTPStubs removeAllStubs];
        });
        
        it(@"should go to failed block after getting news", ^{
            
            __block BOOL failed = NO;
            
            [sut
             newsWithSuccess:nil
             failure:^(NSError *error) {
                 failed = YES;
             }];
            
            [[expectFutureValue(theValue(failed)) shouldEventually] beYes];
        });
        
        it(@"should contain error with right domain and code in failed block", ^{
            
            __block NSError *error;
            
            [sut
             newsWithSuccess:nil
             failure:^(NSError *err) {
                 error = err;
             }];
            
            [[expectFutureValue(error.domain) shouldEventually] equal:responseError.domain];
            [[expectFutureValue(theValue(error.code)) shouldEventually]
             equal:theValue(responseError.code)];
        });
    });
});

SPEC_END
