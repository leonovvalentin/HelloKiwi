//
//  News.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



@interface News : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *descriptionOfNews;
@property (strong, nonatomic) NSDate *pubDate;
@property (strong, nonatomic) NSString *guid;

@end
