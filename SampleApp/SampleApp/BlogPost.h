//
//  BlogPost.h
//  SampleApp
//
//  Created by Oleg Stasula on 20.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

@class FieldBlogImage;


@interface BlogPost : DrupalEntity

@property (nonatomic) NSString *title;
@property (nonatomic) NSDictionary *body;
@property (nonatomic) NSString *nid;
@property (nonatomic) NSString *field_blog_author;
@property (nonatomic) NSString *field_blog_date;
@property (nonatomic) NSString *uiid;
@property (nonatomic) NSString *vid;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *langcode;
@property (nonatomic) NSString *uid;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *created;
@property (nonatomic) NSString *changed;
@property (nonatomic) NSString *promote;
@property (nonatomic) NSString *sticky;
@property (nonatomic) NSString *revision_timestemp;
@property (nonatomic) NSString *log;
@property (nonatomic) NSString *field_blog_category;
@property (nonatomic) NSString *field_blog_image;
@property (nonatomic) NSString *field_file;
@property (nonatomic) NSDictionary *field_blog_url;

@end
