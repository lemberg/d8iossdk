//
//  AppDelegate.m
//  SampleApp
//
//  Created by Admin on 5/15/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setTintColor:kLembergPrimaryColor];
    [DrupalAPIManager sharedDrupalAPIManager].baseURL = [NSURL URLWithString:@"http://vh015.uk.dev-ls.co.uk"];
    [[DataManager manager] loadPosts];
    
    return YES;
}


@end
