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
    for (NSString *key in params.allKeys) {
        if ([properties indexOfObject:key] == NSNotFound)
            continue;
        
        NSString *setterName = [NSString stringWithFormat:@"set%@:", [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[key substringToIndex:1] capitalizedString]]];
        SEL setterSelector = NSSelectorFromString(setterName);
        if ([entity respondsToSelector:setterSelector])
            [entity performSelector:setterSelector withObject:[params objectForKey:key]];
    }
    return entity;
}


+ (id)deserializeEntityClass:(Class)entityClass fromDictionary:(NSDictionary *)params {
    return [DrupalEntityDeserializer deserializeEntity:[entityClass new] fromDictionary:params];
}

@end
