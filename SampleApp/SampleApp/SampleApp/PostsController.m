//
//  MainController.m
//  SampleApp
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "PostsController.h"
#import "PostController.h"
#import "BlogPage.h"
#import "BlogPostPreview.h"
#import "DataManager.h"
#import "PostCell.h"
#import <DrupalLib/DrupalSDK.h>


@interface PostsController ()

@property (nonatomic) NSArray *posts;
@property (nonatomic) UIRefreshControl *refreshControl;

@end


@implementation PostsController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView *refreshView = [UIView new];
    [self.tableView insertSubview:refreshView atIndex:0];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl setTintColor:kLembergPrimaryColor];
    [self.refreshControl addTarget:self action:@selector(reloadFeeds) forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:self.refreshControl];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.posts = [[DataManager manager] postsOfCategory:self.category];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReload) name:kDidLoadPostsNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidLoadPostsNotification object:nil];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectBlopPostNotification object:[self.posts objectAtIndex:indexPath.row] userInfo:nil];
}


- (void)reloadFeeds {
    [[DataManager manager] loadPosts];
}


- (void)didReload {
    self.posts = [[DataManager manager] postsOfCategory:self.category];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}


@end
