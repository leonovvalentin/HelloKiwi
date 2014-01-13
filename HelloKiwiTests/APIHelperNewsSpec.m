//
//  APIHelperNewsSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>



SPEC_BEGIN(APIHelperNewsSpec)

describe(@"APIHelperNews", ^{
    
    __block APIHelperNews *sut;
    
    beforeEach(^{
        sut = [[APIHelperNews alloc] init];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    context(@"when success server request", ^{
        
        beforeAll(^{
            [OHHTTPStubs
             stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                 return
                 [request.URL.absoluteString isEqualToString:@"http://news.yandex.ru/index.rss"] ?
                 YES : NO;
             }
             withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                 return
                 [[OHHTTPStubsResponse
                   responseWithFileAtPath:OHPathForFileInBundle(@"newsResponse.rss", nil)
                   statusCode:200
                   headers:@{
                             @"Cache-Control" : @"private, no-cache, no-store",
                             @"Content-Encoding" : @"gzip",
                             @"Content-Type" : @"application/rss+xml; charset=utf-8",
                             @"Date" : @"Sat, 11 Jan 2014 12:15:03 GMT",
                             @"Transfer-Encoding" : @"Identity",
                             @"Vary" : @"Accept-Encoding",
                             @"X-Server" : @"nginx-export"
                             }] requestTime:0.0 responseTime:0.0];
             }];
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
        
        it(@"should return right number of items in success block", ^{
            
            __block NSUInteger count = 0;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 count = news.count;
             }
             failure:nil];
            
            [[expectFutureValue(theValue(count)) shouldEventually] equal:theValue(1)];
        });
        
        it(@"should return News items in success block", ^{
            
            __block BOOL isNewsItems = NO;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 for (id item in news) {
                     if (![item isKindOfClass:[News class]]) {
                         isNewsItems = NO;
                         return;
                     }
                     else {
                         isNewsItems = YES;
                     }
                 }
             }
             failure:nil];
            
            [[expectFutureValue(theValue(isNewsItems)) shouldEventually] beYes];
        });
        
        it(@"should return right News items", ^{
            
            __block BOOL rightNews = NO;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 for (NSUInteger i = 0; i < news.count; i++) {
                     News *newsItem = news[i];
                     
                     switch (i) {
                         case 0: {
                             BOOL rightTitle =
                             [newsItem.title isEqualToString:
                              @"Прокуратура возбудила дело об избиении Юрия Луценко"];
                             
                             BOOL rightLink =
                             [newsItem.link isEqualToString:
                              @"http://news.yandex.ru/yandsearch?cl4url=www.rg.ru%2F2014%2F01%2F11%2Fluzenko-site-anons.html"];
                             
                             BOOL rightDescription =
                             [newsItem.descriptionOfNews isEqualToString:
                              @"&quot;В отношении применения силы к оппозиции и получения телесных повреждений Юрием Луценко на проспекте Перемоги 109 прокуратура Киева начала криминальное расследование по статье превышение служебных полномочий&quot;, - информировала Соболевская."];
                             
                             BOOL rightGuid =
                             [newsItem.guid isEqualToString:
                              @"http://news.yandex.ru/yandsearch?cl4url=www.rg.ru%2F2014%2F01%2F11%2Fluzenko-site-anons.html"];
                             
                             BOOL rightPubDate =
                             [newsItem.pubDate isEqualToDate:
                              [NSDate dateFromString:@"11 Jan 2014 12:47:00 +0400"]];
                             
                             rightNews = rightTitle && rightLink && rightDescription && rightGuid &&
                             rightPubDate;
                             
                             break;
                         }
                         default: {
                             break;
                         }
                     }
                 }
             }
             failure:nil];
            
            [[expectFutureValue(theValue(rightNews)) shouldEventually] beYes];
            
        });
        
    });
    
    context(@"when failed server request", ^{
        
        beforeAll(^{
            [OHHTTPStubs
             stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                 return
                 [request.URL.absoluteString isEqualToString:@"http://news.yandex.ru/index.rss"] ?
                 YES : NO;
             }
             withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                 return [OHHTTPStubsResponse responseWithError:[NSError errorWithDomain:@"TestDomain"
                                                                                   code:0
                                                                               userInfo:nil]];
             }];
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
        
        it(@"should contain error in failed block", ^{
            
            __block NSError *error;
            
            [sut
             newsWithSuccess:nil
             failure:^(NSError *err) {
                 error = err;
             }];
            
            [[expectFutureValue(error) shouldNotEventually] beNil];
            
        });
        
    });
});

SPEC_END
