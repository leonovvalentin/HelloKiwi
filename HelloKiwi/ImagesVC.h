//
//  ImagesVC.h
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/15/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



@interface ImagesVC : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) UIPageViewController *pageVC;

@end
