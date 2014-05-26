//
//  BlogPostPreview.h
//  SampleApp
//
//  Created by Oleg Stasula on 26.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <DrupalLib/DrupalEntity.h>


@interface BlogPostPreview : DrupalEntity

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *body;
@property (nonatomic) NSString *nid;
@property (nonatomic) NSString *field_blog_author;
@property (nonatomic) NSString *field_blog_date;
@property (nonatomic) NSString *field_blog_category;
@property (nonatomic) NSString *field_blog_image;
@property (nonatomic) NSString *field_file;

- (NSString *)dateAndAuthor;

@end
