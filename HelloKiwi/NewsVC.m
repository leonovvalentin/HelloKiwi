//
//  NewsVC.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsVC.h"
#import "NewsDetailVC.h"
#import "NewsCell.h"



@interface NewsVC () <UITableViewDataSource, UITableViewDelegate>
@end



@implementation NewsVC

#pragma mark - init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.title = NSLocalizedString(@"NewsVCTitle", @"NewsVC title");
}

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(updateNews)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetNews];
    [self updateNews];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[NewsDetailVC class]]) {
        [(NewsDetailVC *)segue.destinationViewController setNews:
         self.news[[self.tableView indexPathForCell:sender].row]];
    }
}

#pragma mark - properties

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
     newsWithSuccess:^(NSArray *news) {
         [self resetNews];
         [self.refreshControl endRefreshing];
     }
     failure:nil];
}

- (void)resetNews
{
    self.news = [News MR_findAllSortedBy:NSStringFromSelector(@selector(pubDate)) ascending:NO];
}

@end
