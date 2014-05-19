//
//  Info.h
//  SampleApp
//
//  Created by Oleh Semenyshyn on 5/19/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <DrupalLib/DrupalEntity.h>

@interface Info : DrupalEntity

@property (strong, nonatomic) id nid;
@property (strong, nonatomic) id uiid;
@property (strong, nonatomic) id vid;
@property (strong, nonatomic) id type;
@property (strong, nonatomic) id langcode;
@property (strong, nonatomic) id title;
@property (strong, nonatomic) id uid;
@property (strong, nonatomic) id status;
@property (strong, nonatomic) id created;
@property (strong, nonatomic) id changed;
@property (strong, nonatomic) id promote;
@property (strong, nonatomic) id sticky;
@property (strong, nonatomic) id revision_timestemp;
@property (strong, nonatomic) id log;
@property (strong, nonatomic) id body;
@property (strong, nonatomic) id field_blog_author;
@property (strong, nonatomic) id field_blog_cathegory;
@property (strong, nonatomic) id field_blog_date;
@property (strong, nonatomic) id field_blog_image;

@end
