//
//  FieldBlogImage.m
//  SampleApp
//
//  Created by Oleh Semenyshyn on 5/19/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "FieldBlogImage.h"

@implementation FieldBlogImage
@synthesize drupalSet = _drupalSet;
@synthesize drupalDictionary = _drupalDictionary;

- (id)init {
    if (self = [super init]) {
        _drupalSet = [[DrupalSet alloc] initWithClass:[DrupalEntity class]];
        _drupalDictionary = [[DrupalDictionary alloc] initWithClass:[DrupalEntity class]];
    }
    
    return self;
}

@end
