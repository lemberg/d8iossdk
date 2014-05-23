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


- (void)pushToServerWithDelegate:(EntityActionHandler)handler {
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self];
}


- (void)patchDataServerWithDelegate:(EntityActionHandler)handler {
    
}


- (void)deleteFromServerWithDelegate:(EntityActionHandler)handler {
    
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


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.oid, self.path];
}


@end
