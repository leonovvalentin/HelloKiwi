//
//  NewsDetailVCSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/14/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsDetailVC.h"
#import "News+Tests.h"
#import <Kiwi/Kiwi.h>



SPEC_BEGIN(NewsDetailVCSpec)

describe(@"NewsDetailVC", ^{
    
    __block NewsDetailVC *sut;
    
    beforeEach(^{
        sut = (NewsDetailVC *)[[UIStoryboard storyboardWithName:@"HelloKiwi" bundle:nil]
                               instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
        sut.news = [News testNews];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    context(@"after viewDidLoad", ^{
        
        beforeEach(^{
            [sut viewDidLoad];
        });
        
        it(@"should have right title", ^{
            [[sut.title should] equal:sut.news.title];
        });
    });
});

SPEC_END
