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


#import "PostsController.h"
#import "PostController.h"
#import "BlogPage.h"
#import "BlogPostPreview.h"
#import "DataManager.h"
#import "PostCell.h"


@interface PostsController ()

@property (nonatomic) NSArray *posts;

@end


@implementation PostsController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.posts = [[DataManager manager] postsOfCategory:self.category];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReload) name:kDidLoadPostsNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidLoadPostsNotification object:nil];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"postCellId";
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSAssert(cell, @"no cell prototype");
    
    BlogPostPreview *bp = [self.posts objectAtIndex:indexPath.row];
    cell.titleLabel.text = bp.title;
    cell.dateLabel.text = [bp dateAndAuthor];
    cell.detailLabel.text = bp.body;
    cell.postImageView.image = nil;
    [cell.postImageView setImageWithURL:[NSURL URLWithString:bp.field_file]];
    if (indexPath.row == self.posts.count - 1)
        [[DataManager manager] loadPosts];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectBlopPostNotification object:[self.posts objectAtIndex:indexPath.row] userInfo:nil];
}


- (void)reloadFeeds
{
    [[DataManager manager] loadPosts];
}


- (void)didReload
{
    self.posts = [[DataManager manager] postsOfCategory:self.category];
    [self.tableView reloadData];
}


@end
