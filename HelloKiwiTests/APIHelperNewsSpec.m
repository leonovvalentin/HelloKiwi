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
        [OHHTTPStubs removeAllStubs];
    });
    
    context(@"success server request", ^{
        
        beforeEach(^{
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
        
        it(@"should go to success block after getting news", ^{
            
            __block BOOL success = NO;
            
            [sut
             newsWithSuccess:^(NSArray *news) {
                 success = YES;
             }
             failure:nil];
            
            [[expectFutureValue(theValue(success)) shouldEventually] beYes];
        });
        
    });
    
    context(@"failed server request", ^{
        
        beforeEach(^{
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
