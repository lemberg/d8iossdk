//
//  DrupalEntity.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DrupalEntity;
@protocol DrupalEntityDelegate <NSObject>
- (void)entity:(DrupalEntity *)entity failedRequestWithError:(NSError *)error;
- (void)entityDidRemove:(DrupalEntity *)entity;
- (void)entityDidPush:(DrupalEntity *)entity;
- (void)entityDidPull:(DrupalEntity *)entity;
- (void)entityDidPatched:(DrupalEntity *)entity;
@end

@interface DrupalEntity : NSObject
//path to object on server (http://www.servername.com/path/oid)
@property (strong, nonatomic) NSString *path;
//identificator to object on server (http://www.servername.com/path/oid)
@property (strong, nonatomic) NSString *oid;

- (void)pullFromServerWithDelegate:(id <DrupalEntityDelegate>) delegate;
- (void)pushToServerWithDelegate:(id <DrupalEntityDelegate>) delegate;
- (void)patchDataServerWithDelegate:(id <DrupalEntityDelegate>) delegate;
- (void)deleteFromServerWithDelegate:(id <DrupalEntityDelegate>) delegate;

- (Class)className;
- (Class)classByPropertyName:(NSString *)propertyName;

@end
