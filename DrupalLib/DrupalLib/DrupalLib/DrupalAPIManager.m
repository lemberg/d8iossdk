//
//  DrupalAPIManager.m
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalAPIManager.h"
#import "DrupalEntityDeserializer.h"
#import "AFHTTPRequestOperationManager+DrupalLib.h"


static DrupalAPIManager *sharedDrupalAPIManager;


@implementation DrupalAPIManager

+ (DrupalAPIManager*)sharedDrupalAPIManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDrupalAPIManager = [DrupalAPIManager new];
    });
    return sharedDrupalAPIManager;
}


- (void)postEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block {
    [[AFHTTPRequestOperationManager defaultManager] POST:[self pathForEntity:entity]
                                              parameters:[entity toJSONDictionary]
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     NSLog(@"%@", [DrupalEntityDeserializer deserializeEntity:entity fromData:responseObject]);
                                                 }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     NSLog(@"postEntity error:%@", error.description);
                                                 }];
}


- (void)getEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block {
    [[AFHTTPRequestOperationManager defaultManager] GET:[self pathForEntity:entity]
                                             parameters:[entity requestGETParams]
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                    NSLog(@"%@", responseObject);
                                                    id result;
                                                    if ([responseObject isKindOfClass:[NSArray class]])             //  Server returned an array of objects.
                                                        result = [DrupalEntityDeserializer deserializeEntities:entity fromData:responseObject];
                                                    else if ([responseObject isKindOfClass:[NSDictionary class]])   //  Server returned a single object. Update the entity.
                                                        result = [DrupalEntityDeserializer deserializeEntity:entity fromData:(NSDictionary *)responseObject];
                                                    if (block)
                                                        block(result, nil);
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
