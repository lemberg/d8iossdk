//
//  The MIT License (MIT)
//  Copyright (c) 2014 Lemberg Solutions Limited
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
