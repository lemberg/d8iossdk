//
//  DrupalAPIManager.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalAPIManager.h"
#import "DrupalEntityDeserializer.h"
#import "DrupalEntitySerializer.h"
#import "AFHTTPRequestOperationManager+DrupalLib.h"


static DrupalAPIManager *sharedDrupalAPIManager;


@implementation DrupalAPIManager

+ (DrupalAPIManager*)sharedDrupalAPIManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDrupalAPIManager = [[DrupalAPIManager alloc] init];
    });
    return sharedDrupalAPIManager;
}


- (void)postEntity:(DrupalEntity*)entity{
    NSString* fullPath = [self pathForEntity:entity];
    [[AFHTTPRequestOperationManager defaultManager] POST:fullPath
       parameters:[DrupalEntitySerializer serializeEntity:entity]
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"%@",[DrupalEntitySerializer serializeEntity: entity]);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"postEntity error:%@",error.description);
          }];
}


- (void)getEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block{
    NSString* fullPath = [self pathForEntity:entity];
    [[AFHTTPRequestOperationManager defaultManager] GET:fullPath
      parameters:[entity requestGETParams]
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             id result;
             if ([responseObject isKindOfClass:[NSArray class]])
                 result = [DrupalEntityDeserializer deserializeEntities:entity fromData:responseObject];
             else if ([responseObject isKindOfClass:[NSDictionary class]])
                 result = [DrupalEntityDeserializer deserializeEntity:entity fromData: (NSDictionary *)responseObject];
             if (block)
                 block(result, nil);
             NSLog(@"%@", result);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"getEntity error:%@",error.description);
             if (block)
                 block(nil, error);
         }];
}


- (NSString*)pathForEntity:(DrupalEntity*)entity{
    NSString* fullPath = [[self.baseURL absoluteString]stringByAppendingPathComponent: entity.path];
    return fullPath;
}


@end
