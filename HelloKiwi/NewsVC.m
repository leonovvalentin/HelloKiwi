//
//  NewsVC.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "NewsCell.h"



@interface NewsVC () <UITableViewDataSource, UITableViewDelegate>
@end



@implementation NewsVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.APIHelper
     newsWithSuccess:^(NSArray *n) {
         self.news = n;
     }
     failure:nil];
}

- (void)setNews:(NSArray *)news
{
    _news = news;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setupWithNews:self.news[indexPath.row]];
    return cell;
}

@end
