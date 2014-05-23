//
// Created by Oleg Stasula on 23.05.14.
// Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kDidLoadPostsNotification           @"DidLoadPostsNotification"

@interface DataManager : NSObject

+ (instancetype)manager;

- (void)loadPosts;
- (NSArray *)posts;
- (NSArray *)postsOfCategory:(NSString *)category;

@end