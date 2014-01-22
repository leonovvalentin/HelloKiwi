//
//  NewsCellSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/13/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NewsCell.h"
#import <Kiwi/Kiwi.h>



SPEC_BEGIN(NewsCellSpec)

describe(@"NewsCell", ^{
    
    __block NewsCell *sut;
    __block UILabel *titleLabel;
    __block UILabel *pubDateLabel;
    
    beforeEach(^{
        
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        
        titleLabel = [[UILabel alloc] init];
        pubDateLabel = [[UILabel alloc] init];
        
        sut = [[NewsCell alloc] init];
        sut.titleLabel = titleLabel;
        sut.pubDateLabel = pubDateLabel;
    });
    
    afterEach(^{
        sut = nil;
        titleLabel = nil;
        pubDateLabel = nil;
        [MagicalRecord cleanUp];
    });
    
    context(@"after setupWithNews:", ^{
        
        __block News *news;
        
        beforeEach(^{
            
            news = [News MR_createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
            news.title = @"One news";
            news.link = @"http://one.news.com";
            news.descriptionOfNews = @"Ordinary news";
            news.pubDate = [NSDate date];
            news.guid = @"http://one.news.com/guid";
            
            [sut setupWithNews:news];
        });
        
        it(@"title label should be right", ^{
            [[sut.titleLabel.text should] equal:news.title];
        });
        
        it(@"pub date label should be right", ^{
            [[sut.pubDateLabel.text should] equal:news.pubDate.description];
        });
        
        it(@"news should be right", ^{
            [[sut.news should] equal:news];
        });
    });
});

SPEC_END
