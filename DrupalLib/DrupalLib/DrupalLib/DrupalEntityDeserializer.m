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

+ (id)deserializeEntity:(DrupalEntity *)entity fromData:(id)params
{
    if ([params isKindOfClass:[NSDictionary class]]) {
        return [DrupalEntityDeserializer deserializeEntity:entity withDictionary:params];
    } else if ([params isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *d in params)
            [array addObject:[DrupalEntityDeserializer deserializeEntity:[[entity class] new] withDictionary:d]];
        return array;
    }
    return nil;
}


+ (id)deserializeEntityClass:(Class)entityClass fromData:(id)params {
    return [DrupalEntityDeserializer deserializeEntity:[entityClass new] fromData:params];
}


+ (id)deserializeEntity:(DrupalEntity *)entity withDictionary:(NSDictionary *)params {
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
        if ([value isKindOfClass:[NSDictionary class]] && [propClass isSubclassOfClass:[DrupalEntity class]]) {
            value = [DrupalEntityDeserializer deserializeEntityClass:propClass fromData:value];
        } else if ([value isKindOfClass:[NSArray class]] && [itemClass isSubclassOfClass:[DrupalEntity class]]) {
            NSMutableArray *obj = [NSMutableArray array];
            for (NSDictionary *d in value)
                [obj addObject:[DrupalEntityDeserializer deserializeEntityClass:itemClass fromData:d]];
            value = obj;
        }
        [entity performSelector:setterSelector withObject:value];
    }
    return entity;
}


@end
