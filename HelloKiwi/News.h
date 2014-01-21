//
//  News.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 20/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



@interface News : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate * pubDate;
@property (nonatomic, retain) NSString * descriptionOfNews;
@property (nonatomic, retain) NSString * guid;

@end
