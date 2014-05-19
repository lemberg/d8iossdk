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

    }
    
    return self;
}

- (id)initWithServerURL:(NSString *)serverURL {
    
    if (self = [super init]) {
        _serverName = serverURL;
        [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:serverURL];
    }
    
    return self;
}

- (void)setServerName:(NSString *)serverName {
    _serverName = serverName;
    [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:_serverName];
}

- (void)pullFromServer {
    [[DrupalAPIManager sharedDrupalAPIManager] getEntity:self];
}

- (void)pushToServer {
    [[DrupalAPIManager sharedDrupalAPIManager] postEntity:self];
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

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@", self.oid, self.serverName, self.path];
}

@end
