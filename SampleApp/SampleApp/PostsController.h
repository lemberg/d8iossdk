//
//  MainController.h
//  SampleApp
//
//  Created by Oleg Stasula on 22.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kDidSelectBlopPostNotification              @"DidSelectBlopPostNotification"


@interface PostsController : UITableViewController

@property (nonatomic) NSString *category;

@end
