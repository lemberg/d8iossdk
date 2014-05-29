//
// Created by Oleg Stasula on 23.05.14.
// Copyright (c) 2014 ls. All rights reserved.
//

#import "DataManager.h"
#import "BlogPage.h"
#import "BlogPost.h"


@implementation DataManager {
    NSArray *posts;
    NSInteger page;
    BOOL isLoading;
}

+ (instancetype)manager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


- (void)loadPosts {
    if (isLoading || page == -1)
        return;
    
    if (!posts)
        posts = [NSArray array];
    
    isLoading = YES;
    [self load:posts];
}


- (void)load:(NSArray *)content {
    NSLog(@"load posts %d", page);
    BlogPage *bp = [BlogPage new];
    bp.page = @(page);
    [bp pullFromServer:^(NSArray *result) {
        if (result) {
            [self didLoad:[[NSMutableArray arrayWithArray:content] arrayByAddingObjectsFromArray:result]];
            page = result.count ? page + 1 : -1;        //  -1 - all content is downloaded
        } else {
            [self didLoad:content];
        }
    }];
}


- (void)didLoad:(NSArray *)content {
    posts = content;
    isLoading = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidLoadPostsNotification object:nil];
}


- (NSArray *)posts {
    return posts;
}


- (NSArray *)postsOfCategory:(NSString *)category {
    if (!category)
        return posts;
    NSMutableArray *array = [NSMutableArray array];
    for (BlogPost *bp in posts) {
        if ([bp.field_blog_category isEqualToString:category])
            [array addObject:bp];
    }
    return array;
}


@end