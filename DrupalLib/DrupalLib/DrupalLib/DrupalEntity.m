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

- (void)pullFromServer:(EntityActionHandler)handler {
    [[DrupalAPIManager sharedDrupalAPIManager] getEntity:self completeHandler:^(id object, NSError *error) {
        if (handler)
            return error ? handler(nil) : handler(object);
    }];
}


- (void)pushToServer:(EntityActionHandler)handler {
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self completeHandler:^(id object, NSError *error) {
        if (handler)
            return error ? handler(nil) : handler(object);
    }];
}


- (void)patchServerData:(EntityActionHandler)handler {
    //  TODO: implement patching object on server    
}


- (void)deleteFromServer:(EntityActionHandler)handler {
    //  TODO: implement deleting object from server
}


- (Class)classOfItems:(NSString *)propertyName {
    return nil;
}


- (NSDictionary *)requestGETParams {
    return nil;
}


- (NSDictionary *)toJSONDictionary {
    return [DrupalEntitySerializer serializeEntity:self];
}


- (BOOL)isPropertyTransient:(NSString *)propertyName {
    return NO;
}


@end
