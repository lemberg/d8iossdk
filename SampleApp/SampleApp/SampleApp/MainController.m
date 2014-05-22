//
//  MainController.m
//  SampleApp
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "MainController.h"
#import "PostController.h"
#import "BlogPost.h"


@interface MainController ()

@property (nonatomic) NSArray *posts;
- (IBAction)endRefreshing:(UIRefreshControl *)sender;

@end


@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.posts = [NSArray array];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"postCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    NSAssert(cell, @"no cell prototype");
    BlogPost *bp = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = bp.title;
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"openPostDetails"]) {
        PostController *pc = segue.destinationViewController;
        BlogPost *bp = [self.posts objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        pc.post = bp;
    }
}


- (IBAction)endRefreshing:(UIRefreshControl *)sender {
    [sender endRefreshing];
}


@end
