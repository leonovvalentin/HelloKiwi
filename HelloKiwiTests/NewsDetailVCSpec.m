//
//  NewsDetailVCSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/14/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsDetailVC.h"

#import "News+Tests.h"
#import "NSString+Tests.h"

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
    
    context(@"after view was loaded", ^{
        
        beforeEach(^{
            [sut view];
        });
        
        it(@"should have right titleLabel text", ^{
            [[sut.titleLabel.text should] equal:sut.news.title];
        });
        
        it(@"should have titleLabel height", ^{
            [[theValue(sut.titleLabel.frame.size.height) should]
             equal:[sut.news.title rightSizeInLabel:sut.titleLabel].height
             withDelta:1.0];
        });
        
        it(@"should have right descriptionOfNewsLabel", ^{
            [[sut.descriptionOfNewsLabel.text should] equal:sut.news.descriptionOfNews];
        });
        
        it(@"should have right descriptionOfNewsLabel height", ^{
            [[theValue(sut.descriptionOfNewsLabel.frame.size.height) should]
             equal:[sut.news.descriptionOfNews rightSizeInLabel:sut.descriptionOfNewsLabel].height
             withDelta:1.0];
        });
        
        it(@"should have right linkLabel", ^{
            [[sut.linkLabel.text should] equal:sut.news.link];
        });
        
        it(@"should have right pubDateLabel", ^{
            [[sut.pubDateLabel.text should] equal:sut.news.pubDate.description];
        });
        
        it(@"should open safary after linkLabelTapped: ", ^{
            [[[UIApplication sharedApplication] should] receive:@selector(openURL:)
                                                  withArguments:[NSURL URLWithString:sut.news.link]];
            [sut linkLabelTapped:nil];
        });
    });
});

SPEC_END
