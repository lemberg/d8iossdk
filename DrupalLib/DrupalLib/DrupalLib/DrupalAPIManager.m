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
    NSString* fullPath = entity.path;
}

-(void) getEntity:(DrupalEntity*)entity{
//    __block dispatch_block_t block = ^(){
        NSError *blockError;
        NSString* fullPath = [[self.baseURL absoluteString]stringByAppendingPathComponent: entity.path];
    
        [AFHTTPRequestOperationManager manager]GET:fullPath parameters:[DrupalEntitySerializer serializeEntity:entity]
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            blockError = error;
        };
//        block();
//    };
}
/*- (void)testWithHandler:(void(^)(int result))handler{
     [obj somemethodwithcompeltionblock:^{
         int someInt = 10;
         dispatch_async(dispatch_get_main_queue(), ^{
             handler(10);
         });
     }
     ];
 }
 - (void)callSite{
     [self testWithHandler:^(int testResult){
         NSLog(@"Result was %d", testResult);
     }];
 }*/

-(void) getEntityWithBlock:(void (^)(DrupalEntity *entity))handler{
    NSString* fullPath = entity.path;
    NSURL *url = [NSURL URLWithString:fullPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //HTTP Request
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //request succeeded
        dispatch_async(dispatch_get_main_queue(), ^handler{
            NSLog(@"JSON:%@",(NSString*)responseObject);
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //request failed
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

//    NSString* fullPath = entity.path;
//    NSDictionary* params = [NSDictionary dictionary];
//    //create URL
//    NSURL *url = [NSURL URLWithString:fullPath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    //HTP Request
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //request succeeded
//        NSLog(@"JSON:%@",(NSString*)responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //request failed
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    //
    [operation start];
}

@end
