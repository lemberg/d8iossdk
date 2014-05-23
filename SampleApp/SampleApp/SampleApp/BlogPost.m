//
//  BlogPost.m
//  SampleApp
//
//  Created by Oleg Stasula on 20.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "BlogPost.h"
#import "FieldBlogImage.h"


@implementation BlogPost

- (Class)classByPropertyName:(NSString *)propertyName {
//    if ([propertyName isEqualToString:@"field_blog_image"])
//        return [FieldBlogImage class];
    return nil;
}


- (NSString *)path {
    return [NSString stringWithFormat:@"node/%@", self.nid];
}


@end
