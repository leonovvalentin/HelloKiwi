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
    self.title = self.news.title;
}

@end
