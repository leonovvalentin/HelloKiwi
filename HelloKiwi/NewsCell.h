//
//  NewsCell.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/13/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "News.h"



@interface NewsCell : UITableViewCell

@property (strong, nonatomic) News *news;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;

- (void)setupWithNews:(News *)news;

@end
