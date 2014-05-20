//
//  DrupalAPIManager.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrupalEntity.h"

@interface DrupalAPIManager : NSObject

@property NSURL *baseURL;

+(DrupalAPIManager*) sharedDrupalAPIManager;

-(void) postEntity:(DrupalEntity*)entity;
-(void) postEntityWithBlock:(void(^)(DrupalEntity *))handler;
-(void) getEntity:(DrupalEntity*)entity;
-(void) getEntityWithBlock:(void(^)(DrupalEntity *))handler;

@end
