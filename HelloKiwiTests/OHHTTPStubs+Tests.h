//
//  OHHTTPStubs+Tests.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/13/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "OHHTTPStubs.h"



@interface OHHTTPStubs (Tests)

+ (void)setupSuccessResponseForAPIHelperNews;
+ (void)setupFailedResponseForAPIHelperNewsWithError:(NSError *)error;

@end
