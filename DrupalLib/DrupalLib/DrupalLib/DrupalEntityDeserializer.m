//
//  DrupalEntityDeserializer.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntityDeserializer.h"
#import "DrupalEntity.h"
#import "DrupalEntity+Properties.h"


@implementation DrupalEntityDeserializer

+ (id)deserializeEntity:(DrupalEntity *)entity fromDictionary:(NSDictionary *)params
{
    NSArray *properties = [entity allProperties];
    for (NSString *prop in params.allKeys) {
        if ([properties indexOfObject:prop] == NSNotFound)
            continue;
        
        NSString *setterName = [NSString stringWithFormat:@"set%@:", [prop stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[prop substringToIndex:1] capitalizedString]]];
        SEL setterSelector = NSSelectorFromString(setterName);
        if (![entity respondsToSelector:setterSelector])
            continue;
        
        Class propClass = [entity classOfProperty:prop];
        Class itemClass = [entity classByPropertyName:prop];
        id value = [params objectForKey:prop];
        if ([value isKindOfClass:[NSDictionary class]]) {
            if ([propClass isSubclassOfClass:[DrupalEntity class]])
                value = [DrupalEntityDeserializer deserializeEntityClass:propClass fromDictionary:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            if ([itemClass isSubclassOfClass:[DrupalEntity class]]) {
                NSMutableArray *obj = [NSMutableArray array];
                for (NSDictionary *d in value)
                    [obj addObject:[DrupalEntityDeserializer deserializeEntityClass:itemClass fromDictionary:d]];
                value = obj;
            }
        }
        [entity performSelector:setterSelector withObject:value];
    }
    return entity;
}


+ (id)deserializeEntityClass:(Class)entityClass fromDictionary:(NSDictionary *)params {
    return [DrupalEntityDeserializer deserializeEntity:[entityClass new] fromDictionary:params];
}

@end
