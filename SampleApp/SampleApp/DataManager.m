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


- (void)loadPosts
{
    if (isLoading || page == -1)
        return;
    
    if (!posts)
        posts = [NSArray array];
    
    isLoading = YES;
    [self load:posts];
}


//  Load next page
- (void)load:(NSArray *)content
{
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


- (void)didLoad:(NSArray *)content
{
    posts = content;
    isLoading = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidLoadPostsNotification object:nil];
}


- (NSArray *)posts {
    return posts;
}


- (NSArray *)postsOfCategory:(NSString *)category
{
    if (!category)
        return posts;
    
    NSMutableArray *array = [NSMutableArray array];
    for (BlogPost *bp in posts)
        if ([bp.field_blog_category isEqualToString:category])
            [array addObject:bp];
    return array;
}


@end