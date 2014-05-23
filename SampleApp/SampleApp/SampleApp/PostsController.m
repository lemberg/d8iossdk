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
#import "BlogPost.h"
#import "DataManager.h"
#import "PostCell.h"


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
    BlogPost *bp = [self.posts objectAtIndex:indexPath.row];
    NSInteger start = [bp.title rangeOfString:@"\">"].location + 2;
    NSInteger end = [bp.title rangeOfString:@"</a>"].location;
    cell.titleLabel.text = [bp.title substringWithRange:NSMakeRange(start, end - start)];
    cell.detailLabel.text = [NSString stringWithFormat:@"%@ by %@", bp.field_blog_date, [bp.field_blog_author isKindOfClass:[NSNull class]] ? @"" : bp.field_blog_author];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDidSelectBlopPostNotification object:[self.posts objectAtIndex:indexPath.row] userInfo:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openPostDetails"]) {
        PostController *pc = segue.destinationViewController;
        BlogPost *bp = [self.posts objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        pc.post = bp;
    }
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
