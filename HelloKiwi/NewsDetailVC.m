//
//  NewsDetailVC.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/14/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsDetailVC.h"



@interface NewsDetailVC ()
@end



@implementation NewsDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = self.news.title;
    [self.titleLabel sizeToFit];
    
    self.descriptionOfNewsLabel.text = self.news.descriptionOfNews;
    [self.descriptionOfNewsLabel sizeToFit];
    
    self.linkLabel.text = self.news.link;
    self.pubDateLabel.text = self.news.pubDate.description;
}

- (IBAction)linkLabelTapped:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.news.link]];
}

@end
