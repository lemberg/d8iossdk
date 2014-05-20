//
//  DrupalAPIManager.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalAPIManager.h"
#import "AFNetworking.h"
#import "DrupalEntityDeserializer.h"
#import "DrupalEntitySerializer.h"

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
    NSString* fullPath = [self getFullPathForEntity:entity];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [[manager requestSerializer] setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager POST:fullPath parameters:[DrupalEntitySerializer serializeEntity:entity]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSLog(@"%@",[DrupalEntitySerializer serializeEntity: entity]);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"getEntity error:%@",error.description);
         }];}

-(void) getEntity:(DrupalEntity*)entity{
    NSString* fullPath = [self getFullPathForEntity:entity];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [[manager requestSerializer] setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [manager GET:fullPath parameters:[entity requestGETParams]
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [DrupalEntityDeserializer deserializeEntity:entity fromDictionary: (NSDictionary *)responseObject];
        NSLog(@"%@",[entity description]);
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"getEntity error:%@",error.description);
    }];
}

-(NSString*)getFullPathForEntity:(DrupalEntity*)entity{
    NSString* fullPath = [[self.baseURL absoluteString]stringByAppendingPathComponent: entity.path];
    fullPath = [fullPath stringByAppendingString:@"/2"];
//    NSLog(@"full path:%@",fullPath);
    return fullPath;
}
@end
