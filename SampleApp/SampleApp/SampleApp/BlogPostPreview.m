//
//  BlogPostPreview.m
//  SampleApp
//
//  Created by Oleg Stasula on 26.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "BlogPostPreview.h"


@implementation BlogPostPreview

- (NSString *)dateAndAuthor {
    return [NSString stringWithFormat:@"%@ %@", self.field_blog_date, [self.field_blog_author isEqualToString:@""] ? @"" : [@"by " stringByAppendingString:self.field_blog_author]];
}


@end
