//
//  News+Tests.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/14/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "News+Tests.h"



@implementation News (Tests)

+ (News *)testNews
{
    News *news = [[News alloc] init];
    news.title = @"One news";
    news.link = @"http://one.news.com";
    news.descriptionOfNews = @"Ordinary news";
    news.pubDate = [NSDate date];
    news.guid = @"http://one.news.com/guid";
    
    return news;
}

+ (News *)anotherTestNews
{
    News *news = [[News alloc] init];
    news.title = @"One more news";
    news.link = @"http://one.more.news.com";
    news.descriptionOfNews = @"Ordinary news. One more.";
    news.pubDate = [NSDate date];
    news.guid = @"http://one.more.news.com/guid";
    
    return news;
}

@end
