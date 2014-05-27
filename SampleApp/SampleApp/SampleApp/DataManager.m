//
// Created by Oleg Stasula on 23.05.14.
// Copyright (c) 2014 ls. All rights reserved.
//

#import "DataManager.h"
#import "BlogPage.h"
#import "BlogPost.h"


@implementation DataManager {
    NSArray *posts;
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
    if (isLoading)
        return;
    
    isLoading = YES;
    [self load:[NSArray array] page:0];
}


- (void)load:(NSArray *)content page:(NSInteger)page {
    BlogPage *bp = [BlogPage new];
    bp.page = @(page);
    [bp pullFromServer:^(id result) {
        NSArray *newContent = result;
        if ([newContent isKindOfClass:[NSArray class]]) {
            if (newContent.count)
                [self load:[[NSMutableArray arrayWithArray:content] arrayByAddingObjectsFromArray:newContent] page:page + 1];
            else
                [self didLoad:[[NSMutableArray arrayWithArray:content] arrayByAddingObjectsFromArray:newContent]];
        } else
            [self didLoad:@[]];
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