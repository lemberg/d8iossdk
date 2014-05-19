//
//  DrupalAPIManager.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalAPIManager.h"

static DrupalAPIManager *sharedDrupalAPIManager;

@implementation DrupalAPIManager

@synthesize baseURL;

-(id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

+(DrupalAPIManager*) sharedDrupalAPIManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDrupalAPIManager = [[DrupalAPIManager alloc] init];
    });
    return sharedDrupalAPIManager;
}

-(void) postEntity:(DrupalEntity*)entity{
    //NSString* fullPath = [NSString stringWithContentsOfURL:<#(NSURL *)#> encoding:<#(NSStringEncoding)#> error:<#(NSError *__autoreleasing *)#> baseURL]
}

-(void) getEntity:(DrupalEntity*)entity{
    
}

@end
