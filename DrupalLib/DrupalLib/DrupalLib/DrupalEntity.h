//
//  DrupalEntity.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrupalEntity : NSObject
//path to object on server (http://www.servername.com/path/oid)
@property (strong, nonatomic) NSString *path;
//identificator to object on server (http://www.servername.com/path/oid)
@property (strong, nonatomic) NSString *oid;
//server name (http://www.servername.com)
@property (strong, nonatomic) NSString *serverName;

- (id)initWithServerURL:(NSString *)serverURL;

- (void)pullFromServer;
- (void)pushToServer;
- (void)patchDataServer;
- (void)deleteFromServer;

//return object in dictionary
- (NSDictionary *)buildDictionary;

@end
