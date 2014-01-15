//
//  NewsSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/15/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "News+Tests.h"
#import <Kiwi/Kiwi.h>



SPEC_BEGIN(NewsSpec)

describe(@"News", ^{
    
    __block News *sut;
    
    beforeEach(^{
        sut = [News testNews];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should return right URL", ^{
        [[[[sut URL] absoluteString] should] equal:sut.link];
    });
});

SPEC_END
