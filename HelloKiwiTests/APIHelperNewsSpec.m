//
//  APIHelperNewsSpec.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 11/01/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "APIHelperNews.h"
#import <Kiwi/Kiwi.h>



SPEC_BEGIN(APIHelperNewsSpec)

describe(@"APIHelperNews", ^{
    
    __block APIHelperNews *sut;
    
    beforeEach(^{
        sut = [[APIHelperNews alloc] init];
    });
    
    afterEach(^{
        sut = nil;
    });
    
    it(@"should successed after getting news", ^{
        <#code#>
    });
    
});

SPEC_END
