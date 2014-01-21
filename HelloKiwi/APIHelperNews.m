//
//  APIHelper.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"

#import <AFNetworking/AFNetworking.h>
#import <RaptureXML/RXMLElement.h>
#import <OHHTTPStubs/OHHTTPStubs.h>



@implementation APIHelperNews

- (void)newsWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperation *operation =
    [[AFHTTPRequestOperation alloc] initWithRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:@"http://news.yandex.ru/index.rss"]]];
    
    [operation
     setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) success([APIHelperNews newsFromSuccessResponse:responseObject]);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) failure(error);
     }];
    
    [operation start];
}

+ (NSArray *)newsFromSuccessResponse:(NSData *)responseObject
{
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    
    NSMutableArray *news = [NSMutableArray array];
    RXMLElement *channelXML = [[RXMLElement elementFromXMLData:responseObject]
                               child:@"channel"];
    NSArray *elements = [channelXML children:@"item"];
    for (RXMLElement *element in elements) {
        News *newsItem = [News MR_createInContext:context];
        newsItem.title = [element child:@"title"].text;
        newsItem.link = [element child:@"link"].text;
        newsItem.descriptionOfNews = [element child:@"description"].text;
        newsItem.pubDate = [NSDate dateFromString:[element child:@"pubDate"].text];
        newsItem.guid = [element child:@"guid"].text;
        [news addObject:newsItem];
    }
    
    [context MR_saveOnlySelfAndWait];
    return news.copy;
}

@end
