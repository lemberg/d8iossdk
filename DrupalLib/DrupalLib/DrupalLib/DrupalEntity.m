//
//  DrupalEntity.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntity.h"

@implementation DrupalEntity
@synthesize oid = _oid;
@synthesize path = _path;

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
