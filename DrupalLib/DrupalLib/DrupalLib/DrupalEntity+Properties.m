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
    while ([class isSubclassOfClass:[DrupalEntity class]]) {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(class, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            [results addObject:[NSString stringWithUTF8String:propName]];
        }
        free(properties);
        class = [class superclass];
    }
    return [NSArray arrayWithArray:results];
}


- (Class)classOfProperty:(NSString *)propertyName {
    // xcdoc://ios//library/prerelease/ios/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
    Class propertyClass = nil;
    objc_property_t property = class_getProperty([self class], [propertyName UTF8String]);
    NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    NSArray *splitPropertyAttributes = [propertyAttributes componentsSeparatedByString:@","];
    if (splitPropertyAttributes.count > 0) {
        NSString *encodeType = splitPropertyAttributes[0];
        NSArray *splitEncodeType = [encodeType componentsSeparatedByString:@"\""];
        if (splitEncodeType.count > 1) {
            NSString *className = splitEncodeType[1];
            propertyClass = NSClassFromString(className);
        }
    }
    return propertyClass;
}


@end
