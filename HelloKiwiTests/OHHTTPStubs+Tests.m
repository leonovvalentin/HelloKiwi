//
//  OHHTTPStubs+Tests.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/13/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "OHHTTPStubs+Tests.h"



@implementation OHHTTPStubs (Tests)

+ (void)setupSuccessResponseForAPIHelperNews
{
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
}

+ (void)setupFailedResponseForAPIHelperNewsWithError:(NSError *)error;
{
    [OHHTTPStubs
     stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
         return
         [request.URL.absoluteString isEqualToString:@"http://news.yandex.ru/index.rss"] ?
         YES : NO;
     }
     withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
         return [OHHTTPStubsResponse responseWithError:error];
     }];
}

@end
