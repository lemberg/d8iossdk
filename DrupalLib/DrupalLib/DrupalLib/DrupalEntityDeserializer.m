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

+ (id)deserializeEntity:(DrupalEntity *)entity fromData:(NSDictionary *)data
{
    NSArray *properties = [entity allProperties];
    for (NSString *prop in data.allKeys) {
        if ([properties indexOfObject:prop] == NSNotFound || [entity isPropertyTransient:prop])
            continue;
        
        NSString *setterName = [NSString stringWithFormat:@"set%@:", [prop stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[prop substringToIndex:1] capitalizedString]]];
        SEL setterSelector = NSSelectorFromString(setterName);
        if (![entity respondsToSelector:setterSelector])
            continue;
        
        Class propClass = [entity classOfProperty:prop];
        Class itemClass = [entity classOfItems:prop];
        id value = [data objectForKey:prop];
        if ([value isKindOfClass:[NSDictionary class]] && [propClass isSubclassOfClass:[DrupalEntity class]]) {
            value = [DrupalEntityDeserializer deserializeEntityClass:propClass fromData:value];
        } else if ([value isKindOfClass:[NSArray class]]) {
            if ([itemClass isSubclassOfClass:[DrupalEntity class]] && [propClass isSubclassOfClass:[NSArray class]]) {
                NSMutableArray *obj = [NSMutableArray array];
                for (NSDictionary *d in value)
                    [obj addObject:[DrupalEntityDeserializer deserializeEntityClass:itemClass fromData:d]];
                value = obj;
            } else if ([propClass isSubclassOfClass:[DrupalEntity class]]) {
                value = [DrupalEntityDeserializer deserializeEntityClass:propClass fromData:[value firstObject]];
            } else if ([propClass isSubclassOfClass:[NSDictionary class]]) {
                value = [value firstObject]; 
            } else if (![propClass isSubclassOfClass:[NSArray class]]) {
                value = [value firstObject];
                if ([value isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *d = value;
                    value = [d objectForKey:[d.allKeys firstObject]];
                }
            }
        }
        [entity performSelector:setterSelector withObject:value];
    }
    return entity;
}


+ (id)deserializeEntities:(DrupalEntity *)entity fromData:(NSArray *)data
{
    Class class = [entity classOfItems:nil] ? [entity classOfItems:nil] : [entity class];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *d in data)
        [array addObject:[DrupalEntityDeserializer deserializeEntityClass:class fromData:d]];
    return array;
}


+ (id)deserializeEntityClass:(Class)entityClass fromData:(NSDictionary *)data
{
    return [DrupalEntityDeserializer deserializeEntity:[entityClass new] fromData:data];
}


+ (id)deserializeEntitiesClass:(Class)entityClass fromData:(NSArray *)data
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *d in data)
        [array addObject:[DrupalEntityDeserializer deserializeEntity:[entityClass new] fromData:d]];
    return array;
}


@end
