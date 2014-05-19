//
//  DrupalEntity.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntity.h"
#import "DrupalAPIManager.h"

@interface DrupalEntity () {
    DrupalAPIManager* _drupalApiManager;
}
@end

@implementation DrupalEntity
@synthesize oid = _oid;
@synthesize path = _path;
@synthesize serverName = _serverName;

- (id)init {
    
    if (self = [super init]) {
        _drupalApiManager = [[DrupalAPIManager alloc] init];
    }
    
    return self;
}

- (id)initWithServerURL:(NSString *)serverURL {
    
    if (self = [self init]) {
        _serverName = serverURL;
        _drupalApiManager.baseURL = [NSURL URLWithString:serverURL];
    }
    
    return self;
}

- (void)setServerName:(NSString *)serverName {
    
    _serverName = serverName;
    _drupalApiManager.baseURL = [NSURL URLWithString:_serverName];
}

- (void)pullFromServer {
    
}

- (void)pushToServer {
    
}

- (void)patchDataServer {
    
}

- (void)deleteFromServer {
    
}

- (NSDictionary *)buildDictionary {
    
    NSString *oid = _oid ?: @"";
    NSString *path = _path ?: @"";
    
    NSDictionary *dict = @{@"oid" : oid,
                           @"path" : path};
    
    return dict;
}

@end
