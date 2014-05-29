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

+ (DrupalAPIManager*) sharedDrupalAPIManager;
- (void)getEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block;
- (void)postEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block;
- (NSString*)pathForEntity:(DrupalEntity*)entity;

@end
