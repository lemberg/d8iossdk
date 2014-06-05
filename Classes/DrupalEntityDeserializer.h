//
//  DrupalEntityDeserializer.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DrupalEntity;

@interface DrupalEntityDeserializer : NSObject

+ (id)deserializeEntity:(DrupalEntity *)entity fromData:(NSDictionary *)data;
+ (id)deserializeEntities:(DrupalEntity *)entity fromData:(NSArray *)data;
+ (id)deserializeEntityClass:(Class)entityClass fromData:(NSDictionary *)data;
+ (id)deserializeEntitiesClass:(Class)entityClass fromData:(NSArray *)data;

@end
