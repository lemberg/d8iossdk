//
//  DrupalEntity.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^EntityActionHandler)(id result);

@class DrupalEntity;


@interface DrupalEntity : NSObject

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *oid;

- (void)pullFromServer:(EntityActionHandler)handler;
- (void)pushToServerWithDelegate:(EntityActionHandler)handler;
- (void)patchDataServerWithDelegate:(EntityActionHandler)handler;
- (void)deleteFromServerWithDelegate:(EntityActionHandler)handler;

- (Class)classByPropertyName:(NSString *)propertyName;
- (Class)classOfItems:(NSString *)propertyName;
- (NSDictionary *)requestGETParams;

@end
