//
//  DrupalEntity.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
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
