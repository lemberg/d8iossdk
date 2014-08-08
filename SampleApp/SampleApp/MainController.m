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


#import "MainController.h"
#import "PostsController.h"
#import "PostController.h"
#import "BlogPostPreview.h"


@interface MainController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewController *pageController;
@property (nonatomic) NSMutableArray *controllers;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)changeCategory:(UISegmentedControl *)sender;

@end


@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openBlogPost:) name:kDidSelectBlopPostNotification object:nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidSelectBlopPostNotification object:nil];
}


- (void)openBlogPost:(NSNotification *)n
{
    PostController *pc = [self.storyboard instantiateViewControllerWithIdentifier:@"PostController"];
    pc.postPreview = n.object;
    [self.navigationController pushViewController:pc animated:YES];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loadPageController"]) {
        self.controllers = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {           //  Create categories of posts
            PostsController *postsController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostsController"];
            if (i == 0)
                postsController.category = nil;
            else if (i == 1)
                postsController.category = @"Industry news";
            else if (i == 2)
                postsController.category = @"Our posts";
            else if (i == 3)
                postsController.category = @"Tech notes";
            [self.controllers addObject:postsController];
        }        
        self.pageController = segue.destinationViewController;
        self.pageController.dataSource = self;
        self.pageController.delegate = self;
        [self.pageController setViewControllers:@[[self.controllers firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    return index ? [self.controllers objectAtIndex:--index] : nil;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    return index == self.controllers.count - 1 ? nil : [self.controllers objectAtIndex:++index];
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray *)previousViewControllers
       transitionCompleted:(BOOL)completed
{
    NSInteger index = [self.controllers indexOfObject:[self.pageController.viewControllers firstObject]];
    [self.segmentControl setSelectedSegmentIndex:index];
}


- (IBAction)changeCategory:(UISegmentedControl *)sender
{
    [self.pageController setViewControllers:@[[self.controllers objectAtIndex:sender.selectedSegmentIndex]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:YES completion:nil];
}


@end
