//
//  utils.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



NSString * applicationDocumentsDirectory();



@interface NSDate (utils)

+ (NSDate *)dateFromString:(NSString *)dateString;

@end
