//
//  ImagesVCSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/15/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "ImagesVC.h"
#import <Kiwi/Kiwi.h>


SPEC_BEGIN(ImagesVCSpec)

describe(@"ImageVC", ^{
    
    __block ImagesVC *sut;
    
    beforeEach(^{
        sut = [[UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil]
               instantiateViewControllerWithIdentifier:@"ImagesVC"];
        sut.viewControllers = @[[[UIViewController alloc] init],
                    [[UIViewController alloc] init],
                    [[UIViewController alloc] init]];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should return nil in pageViewController:viewControllerBeforeViewController: if VC is first \
       VC", ^{
           [[[sut pageViewController:nil
  viewControllerBeforeViewController:sut.viewControllers.firstObject]
             should] beNil];
       });
    
    it(@"should return first VC if second VC was sended to \
       pageViewController:viewControllerBeforeViewController:", ^{
           [[[sut pageViewController:nil viewControllerBeforeViewController:sut.viewControllers[1]]
             should] equal:sut.viewControllers[0]];
       });
    
    it(@"should return second VC if third VC was sended to \
       pageViewController:viewControllerBeforeViewController:", ^{
           [[[sut pageViewController:nil viewControllerBeforeViewController:sut.viewControllers[2]]
             should] equal:sut.viewControllers[1]];
       });
    
    it(@"should return nil in pageViewController:viewControllerAfterViewController: if VC is last \
       VC", ^{
           [[[sut pageViewController:nil
   viewControllerAfterViewController:sut.viewControllers.lastObject]
             should] beNil];
       });
    
    it(@"should return second VC if first VC was sended to \
       pageViewController:viewControllerAfterViewController:", ^{
           [[[sut pageViewController:nil viewControllerAfterViewController:sut.viewControllers[0]]
             should] equal:sut.viewControllers[1]];
       });
    
    it(@"should return third VC if second VC was sended to \
       pageViewController:viewControllerAfterViewController:", ^{
           [[[sut pageViewController:nil viewControllerAfterViewController:sut.viewControllers[1]]
             should] equal:sut.viewControllers[2]];
       });
    
    it(@"should return right value in presentationCountForPageViewController:", ^{
        [[theValue([sut presentationCountForPageViewController:nil]) should]
         equal:theValue([sut.viewControllers count])];
    });
    
    context(@"after view was loaded", ^{
        
        beforeEach(^{
            [sut view];
        });
        
        context(@"pageVC", ^{
            
            __block UIPageViewController *pageVC;
            
            beforeEach(^{
                pageVC = sut.pageVC;
            });
            
            it(@"should not be nil", ^{
                [[pageVC shouldNot] beNil];
            });
            
            it(@"should have right transitionStyle", ^{
                [[theValue(pageVC.transitionStyle) should]
                 equal:theValue(UIPageViewControllerTransitionStyleScroll)];
            });
            
            it(@"should have right navigationOrientation", ^{
                [[theValue(pageVC.navigationOrientation) should]
                 equal:theValue(UIPageViewControllerNavigationOrientationHorizontal)];
            });
            
            it(@"should have sut as dataSourse", ^{
                [[sut should] equal:pageVC.dataSource];
            });
            
            it(@"should have right viewControllers", ^{
                [[pageVC.viewControllers should] equal:@[sut.viewControllers.firstObject]];
            });
            
            it(@"should be child of sut VC", ^{
                [[sut.childViewControllers should] containObjectsInArray:@[pageVC]];
            });
            
            it(@"view should be subview of sut view", ^{
                [[sut.view.subviews should] containObjectsInArray:@[pageVC.view]];
            });
        });
    });
});

SPEC_END
