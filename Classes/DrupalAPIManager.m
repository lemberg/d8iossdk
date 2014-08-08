//
//  The MIT License (MIT)
//  Copyright (c) 2014 Lemberg Solutions Limited
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


#import "DrupalAPIManager.h"
#import "DrupalEntityDeserializer.h"
#import "AFHTTPRequestOperationManager+DrupalLib.h"


static DrupalAPIManager *sharedDrupalAPIManager;


@implementation DrupalAPIManager

+ (DrupalAPIManager*)sharedDrupalAPIManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDrupalAPIManager = [DrupalAPIManager new];
    });
    return sharedDrupalAPIManager;
}


- (void)postEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block
{
    [[AFHTTPRequestOperationManager defaultManager] POST:[self pathForEntity:entity]
                                              parameters:[entity toJSONDictionary]
                                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     NSLog(@"%@", [DrupalEntityDeserializer deserializeEntity:entity fromData:responseObject]);
                                                 }
                                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     NSLog(@"postEntity error:%@", error.description);
                                                 }];
}


- (void)getEntity:(DrupalEntity*)entity completeHandler:(CompleteHandler)block
{
    [[AFHTTPRequestOperationManager defaultManager] GET:[self pathForEntity:entity]
                                             parameters:[entity requestGETParams]
                                                success:^(AFHTTPRequestOperation *operation, id responseObject) {
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


- (NSString*)pathForEntity:(DrupalEntity*)entity
{
    NSString* fullPath = [[self.baseURL absoluteString]stringByAppendingPathComponent: entity.path];
    return fullPath;
}


@end
