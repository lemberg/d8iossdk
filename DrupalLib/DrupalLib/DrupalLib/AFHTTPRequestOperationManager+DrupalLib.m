//
//  AFHTTPRequestOperationManager+DrupalLib.m
//  DrupalLib
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "AFHTTPRequestOperationManager+DrupalLib.h"


@implementation AFHTTPRequestOperationManager (DrupalLib)

+ (instancetype)defaultManager
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [[manager requestSerializer] setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    return manager;
}


@end
