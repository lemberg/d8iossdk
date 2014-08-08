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
