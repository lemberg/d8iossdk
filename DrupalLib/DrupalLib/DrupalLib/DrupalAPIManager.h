//
//  DrupalAPIManager.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrupalEntity.h"


typedef void (^CompleteHandler)(id response, NSError *error);


@interface DrupalAPIManager : NSObject

@property NSURL *baseURL;

+ (DrupalAPIManager*) haredDrupalAPIManager;

- (void)postEntity:(DrupalEntity*)entity;
- (void)getEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block;

- (NSString*)getFullPathForEntity:(DrupalEntity*)entity;

@end
