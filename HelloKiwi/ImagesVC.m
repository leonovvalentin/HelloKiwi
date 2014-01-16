//
//  ImagesVC.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/15/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "ImagesVC.h"



@interface ImagesVC ()
@end



@implementation ImagesVC

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
    self.title = NSLocalizedString(@"ImagesVCTitle", @"ImagesVC title");
}

#pragma mark - view

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pageVC = [[UIPageViewController alloc]
                   initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                   navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                   options:nil];
    self.pageVC.dataSource = self;
    [self.pageVC setViewControllers:@[self.viewControllers.firstObject]
                          direction:UIPageViewControllerNavigationDirectionForward
                           animated:YES
                         completion:nil];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger indx = [self.viewControllers indexOfObject:viewController];
    if (indx == 0) return nil;
    return self.viewControllers[indx - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger indx = [self.viewControllers indexOfObject:viewController];
    if (indx == [self.viewControllers count] - 1) return nil;
    return self.viewControllers[indx + 1];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.viewControllers count];
}

@end
