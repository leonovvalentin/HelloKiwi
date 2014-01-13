//
//  APIHelper.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "News.h"



@interface APIHelperNews : NSObject

- (void)newsWithSuccess:(void (^)(NSArray *news))success failure:(void (^)(NSError *error))failure;

+ (NSArray *)newsFromSuccessResponse:(NSData *) responseObject;

@end
