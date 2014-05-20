//
//  Info.m
//  SampleApp
//
//  Created by Oleh Semenyshyn on 5/19/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "Info.h"

@implementation Info

- (Class)classByPropertyName:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"fields_blog_image"])
        return [FieldBlogImage class];
    return nil;
}

@end
