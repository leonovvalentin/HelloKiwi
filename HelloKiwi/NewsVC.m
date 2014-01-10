//
//  NewsVC.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"



@implementation NewsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.APIHelper newsWithSuccess:nil failure:nil];
}

@end
