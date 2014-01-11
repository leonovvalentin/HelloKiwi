//
//  APIHelper.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"
#import <AFNetworking/AFNetworking.h>



@implementation APIHelperNews

- (void)newsWithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperation *operation =
    [[AFHTTPRequestOperation alloc] initWithRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:@"http://news.yandex.ru/index.rss"]]];
    
    [operation
     setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) success(nil);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) failure(error);
     }];
    
    [operation start];
}

@end
