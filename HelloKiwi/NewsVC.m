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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"NewsVCTitle", @"NewsVC title");
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(updateNews)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateNews];
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

#pragma mark - helpers

- (void)updateNews
{
    [self.APIHelper
     newsWithSuccess:^(NSArray *n) {
         self.news = n;
         [self.refreshControl endRefreshing];
     }
     failure:nil];
}

@end
