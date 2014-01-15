//
//  NSString+Tests.m
//  HelloKiwi
//
//  Created by Valentin Leonov on 1/15/14.
//  Copyright (c) 2014 noveo. All rights reserved.
//



#import "NSString+Tests.h"



@implementation NSString (Tests)

- (CGSize)rightSizeInLabel:(UILabel *)label
{
    return
    [self
     boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)
     options:NSStringDrawingUsesLineFragmentOrigin | label.lineBreakMode
     attributes:@{NSFontAttributeName : label.font}
     context:nil].size;
}

@end
