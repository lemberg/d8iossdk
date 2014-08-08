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


#import "DrupalEntity.h"
#import "DrupalEntitySerializer.h"
#import "DrupalAPIManager.h"


@implementation DrupalEntity

//  GET object from server
- (void)pullFromServer:(EntityActionHandler)handler
{
    [[DrupalAPIManager sharedDrupalAPIManager] getEntity:self completeHandler:^(id object, NSError *error) {
        if (handler)
            return error ? handler(nil) : handler(object);
    }];
}


//  POST object to server
- (void)pushToServer:(EntityActionHandler)handler
{
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self completeHandler:^(id object, NSError *error) {
        if (handler)
            return error ? handler(nil) : handler(object);
    }];
}


//  PATCH object on server
- (void)patchServerData:(EntityActionHandler)handler
{
    //  TODO: implement patching object on server    
}


//  DELETE object from server
- (void)deleteFromServer:(EntityActionHandler)handler
{
    //  TODO: implement deleting object from server
}


//  Return class of objects into array. Is called only if property type is NSArray.
- (Class)classOfItems:(NSString *)propertyName
{
    return nil;
}


//  Return GET params
- (NSDictionary *)requestGETParams
{
    return nil;
}


//  Override this method to customize serialization
- (NSDictionary *)toJSONDictionary
{
    return [DrupalEntitySerializer serializeEntity:self];
}


//  Return YES for transient properties.
- (BOOL)isPropertyTransient:(NSString *)propertyName
{
    return NO;
}


@end
