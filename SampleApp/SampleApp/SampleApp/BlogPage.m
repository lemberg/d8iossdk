//
//  BlogPage.m
//  SampleApp
//
//  Created by Oleg Stasula on 20.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "BlogPage.h"
#import "BlogPostPreview.h"


@implementation BlogPage

- (NSDictionary *)requestGETParams {
    return @{@"page": self.page};
}


- (NSString *)path {
    return [NSString stringWithFormat:@"blog-rest"];
}


- (Class)classOfItems:(NSString *)propertyName {
    return [BlogPostPreview class];
}


@end
