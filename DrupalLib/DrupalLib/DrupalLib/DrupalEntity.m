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

- (void)pullFromServerWithDelegate:(id<DrupalEntityDelegate>)delegate {
    [[DrupalAPIManager sharedDrupalAPIManager] getEntity:self completeHandler:nil];
}


- (void)pushToServerWithDelegate:(id<DrupalEntityDelegate>)delegate {
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self];
}


- (void)patchDataServerWithDelegate:(id<DrupalEntityDelegate>)delegate {
    
}


- (void)deleteFromServerWithDelegate:(id<DrupalEntityDelegate>)delegate {
    
}


- (Class)classByPropertyName:(NSString *)propertyName {
    return nil;
}


- (NSDictionary *)requestGETParams {
    return nil;
}


- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@", self.oid, self.path];
}


@end
