//
//  DrupalEntity.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntity.h"
#import "DrupalAPIManager.h"


@implementation DrupalEntity

- (void)pullFromServer:(EntityActionHandler)handler {
    [[DrupalAPIManager sharedDrupalAPIManager] getEntity:self completeHandler:^(id response, NSError *error) {
        if (handler)
            return error ? handler(self) : handler(response);
    }];
}


- (void)pushToServer:(EntityActionHandler)handler {
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self];
}


- (void)patchServerData:(EntityActionHandler)handler {
    //  TODO: implement patching object on server    
}


- (void)deleteFromServer:(EntityActionHandler)handler {
    //  TODO: implement deleting object from server
}


- (Class)classByPropertyName:(NSString *)propertyName {
    return nil;
}


- (Class)classOfItems:(NSString *)propertyName {
    return nil;
}


- (NSDictionary *)requestGETParams {
    return nil;
}


@end
