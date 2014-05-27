//
//  PostController.m
//  SampleApp
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "PostController.h"
#import "BlogPostPreview.h"
#import "BlogPost.h"
#import <Social/Social.h>


@interface PostController () <UIWebViewDelegate, UIActionSheetDelegate> {
    BOOL isActionSheetOpen;
}

@property (nonatomic) BlogPost *post;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation PostController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BlogPost *post = [BlogPost new];
    post.nid = self.postPreview.nid;
    [post pullFromServer:^(id result) {
        self.post = result;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"template" ofType:@"html"];
        NSMutableString *html = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [html replaceOccurrencesOfString:@"%ARTICLE_IMAGE_URL%" withString:self.postPreview.field_file options:(NSLiteralSearch) range:NSMakeRange(0, html.length)];
        [html replaceOccurrencesOfString:@"%ARTICLE_TITLE%" withString:self.post.title options:(NSLiteralSearch) range:NSMakeRange(0, html.length)];
        NSString *body = [NSString stringWithFormat:@"<p style=\"color: #888;\">%@</p>%@", [self.postPreview dateAndAuthor], self.post.body[@"value"]];
        [html replaceOccurrencesOfString:@"%ARTICLE_BODY%" withString:body options:(NSLiteralSearch) range:NSMakeRange(0, html.length)];
        [self.webView loadHTMLString:html baseURL:nil];
    }];
    
    self.title = self.postPreview.field_blog_category;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
}


- (void)share {
    if (isActionSheetOpen)
        return;
    isActionSheetOpen = YES;
    [[[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", nil] showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //  Facebook
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            SLComposeViewController *postSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
            [postSheet setInitialText:@"Hello a Facebook"];
            [self presentViewController:postSheet animated:YES completion:nil];
        }
    } else if (buttonIndex == 1) {
        // Twitter
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Hello a Tweet"];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
    }
    isActionSheetOpen = NO;
}


@end
