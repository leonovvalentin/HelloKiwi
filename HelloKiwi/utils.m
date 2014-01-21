//
//  utils.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "utils.h"



@implementation NSDate (utils)

+ (NSDate *)dateFromString:(NSString *)dateString
{
    if (!dateString) return nil;
    
    __block NSDate *date = nil;
    
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingAllTypes
                                                               error:nil];
    [detector
     enumerateMatchesInString:dateString
     options:kNilOptions
     range:NSMakeRange(0, [dateString length])
     usingBlock:^(NSTextCheckingResult *result,
                  NSMatchingFlags flags,
                  BOOL *stop) {
         date = result.date;
     }];
    
    return date;
}

@end
