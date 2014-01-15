//
//  NewsDetailVC.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/14/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "News.h"



@interface NewsDetailVC : UIViewController

@property (strong, nonatomic) News *news;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionOfNewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *linkLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;

@end
