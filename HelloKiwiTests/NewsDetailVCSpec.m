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
    
    context(@"after view was loaded", ^{
        
        beforeEach(^{
            [sut view];
        });
        
        it(@"title should be nil", ^{
            [[sut.title should] beNil];
        });
        
        context(@"titleLabel", ^{
            
            __block UILabel *titleLabel;
            
            beforeEach(^{
                titleLabel = sut.titleLabel;
            });
            
            afterEach(^{
                titleLabel = nil;
            });
            
            it(@"should have right text", ^{
                [[titleLabel.text should] equal:sut.news.title];
            });
            
            it(@"should have right size", ^{
                CGSize size =
                [sut.news.title
                 boundingRectWithSize:CGSizeMake(sut.titleLabel.frame.size.width, CGFLOAT_MAX)
                 options:NSStringDrawingUsesLineFragmentOrigin | sut.titleLabel.lineBreakMode
                 attributes:@{NSFontAttributeName : sut.titleLabel.font}
                 context:nil].size;
                
                [[theValue(sut.titleLabel.frame.size.height) should] equal:size.height
                                                                 withDelta:1.0];
            });
        });
        
        context(@"desctiptionOfNewsLabel", ^{
            
            __block UILabel *descriptionOfNewsLabel;
            
            beforeEach(^{
                descriptionOfNewsLabel = sut.descriptionOfNewsLabel;
            });
            
            afterEach(^{
                descriptionOfNewsLabel = nil;
            });
            
            it(@"should have right text", ^{
                [[descriptionOfNewsLabel.text should] equal:sut.news.descriptionOfNews];
            });
            
            it(@"should have right size", ^{
                CGSize size =
                [sut.news.descriptionOfNews
                 boundingRectWithSize:CGSizeMake(sut.descriptionOfNewsLabel.frame.size.width, CGFLOAT_MAX)
                 options:NSStringDrawingUsesLineFragmentOrigin | sut.descriptionOfNewsLabel.lineBreakMode
                 attributes:@{NSFontAttributeName : sut.descriptionOfNewsLabel.font}
                 context:nil].size;
                
                [[theValue(sut.descriptionOfNewsLabel.frame.size.height) should] equal:size.height
                                                                             withDelta:1.0];
            });
        });
    });
});

SPEC_END
