//
//  DrupalEntity+Properties.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntity+Properties.h"
#import <objc/runtime.h>


@implementation DrupalEntity (Properties)

- (NSArray *)allProperties {
    Class class = [self class];
        
    NSMutableArray *results = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        [results addObject:[NSString stringWithUTF8String:propName]];
    }
    free(properties);
    return [NSArray arrayWithArray:results];
}


@end
