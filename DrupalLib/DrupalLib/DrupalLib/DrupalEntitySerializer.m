//
//  DrupalEntitySerializer.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntitySerializer.h"
#import "DrupalEntity.h"
#import "DrupalEntity+Properties.h"


@implementation DrupalEntitySerializer

+ (NSDictionary *)serializeEntity:(DrupalEntity *)entity {
    NSArray *properties = [entity allProperties];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *prop in properties) {
        SEL propSelector = NSSelectorFromString(prop);
        id value = [entity performSelector:propSelector withObject:nil];
        if (value)
            [dict setObject:value forKey:prop];
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}


@end
