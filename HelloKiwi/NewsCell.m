//
//  NewsCell.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/13/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsCell.h"



@implementation NewsCell

- (void)setupWithNews:(News *)news
{
    self.news = news;
    
    self.titleLabel.text = news.title;
    self.pubDateLabel.text = news.pubDate.description;
}

@end
