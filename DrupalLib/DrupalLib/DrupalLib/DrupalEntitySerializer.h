//
//  DrupalEntitySerializer.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>


@class DrupalEntity;


@interface DrupalEntitySerializer : NSObject

+ (NSDictionary *)serializeEntity:(DrupalEntity *)entity;

@end
