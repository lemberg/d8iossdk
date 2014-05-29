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

+ (NSDictionary *)serializeEntity:(DrupalEntity *)entity
{
    NSArray *properties = [entity allProperties];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (NSString *prop in properties) {
        if ([entity isPropertyTransient:prop])
            continue;
        
        SEL propSelector = NSSelectorFromString(prop);
        Class propClass = [entity classOfProperty:prop];
        id value = [entity performSelector:propSelector withObject:nil];
        
        if (value && [propClass isSubclassOfClass:[DrupalEntity class]]) {
            if ([value isKindOfClass:[NSArray class]]) {
                NSMutableArray *array = [NSMutableArray array];
                for (DrupalEntity* obj in value)
                    [array addObject:[DrupalEntitySerializer serializeEntity:obj]];
                value = array;
            } else if ([value isKindOfClass:[NSSet class]]) {
                NSMutableArray *array = [NSMutableArray array];
                for (DrupalEntity* obj in [value allObjects])
                    [array addObject:[DrupalEntitySerializer serializeEntity:obj]];
                value = array;
            } else if ([value isKindOfClass:[DrupalEntity class]]) {
                value = [DrupalEntitySerializer serializeEntity:value];
            }
        } else if (!value) {
            //  Default value by type
            if ([propClass isSubclassOfClass:[NSArray class]] || [propClass isSubclassOfClass:[NSSet class]])
                value = @[];
            else if ([propClass isSubclassOfClass:[NSDictionary class]] || [propClass isSubclassOfClass:[DrupalEntity class]])
                value = @{};
            else                
                value = @"";
        }
        
        if (value)
            [dict setObject:value forKey:prop];
    }    
    return [NSDictionary dictionaryWithDictionary:dict];
}


@end
