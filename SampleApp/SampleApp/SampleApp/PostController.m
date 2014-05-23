//
//  PostController.m
//  SampleApp
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "PostController.h"
#import "BlogPost.h"
#import <Social/Social.h>


@interface PostController () <UIWebViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end


@implementation PostController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html><head><style>h3{padding: 0; margin: 0;} img {max-width: 100%; heigth: auto;}</style></head><body style=\"background-color: transparent; font-family: HelveticaNeue-Light; color: #686868;\">"];
    [html appendFormat:@"<h3>%@</h3>", self.post.title];
    [html appendFormat:@"<p>%@</p>", self.post.field_blog_image];
    [html appendString:self.post.body];
    [html appendString:@"</body></html>"];
    [self.webView loadHTMLString:html baseURL:nil];
    
    self.title = self.post.field_blog_category;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
}


- (void)share {
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
}


@end
