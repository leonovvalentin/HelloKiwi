//
//  NewsVC.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/10/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"



@interface NewsVC : UIViewController

@property (strong, nonatomic) APIHelperNews *APIHelper;
@property (strong, nonatomic) NSArray *news;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
