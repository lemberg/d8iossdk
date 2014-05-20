//
//  BlogPost.h
//  SampleApp
//
//  Created by Oleg Stasula on 20.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <DrupalLib/DrupalEntity.h>


@interface BlogPost : DrupalEntity

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *body;
@property (nonatomic) NSString *nid;
@property (nonatomic) NSString *field_blog_author;
@property (nonatomic) NSString *field_blog_date;

@end
