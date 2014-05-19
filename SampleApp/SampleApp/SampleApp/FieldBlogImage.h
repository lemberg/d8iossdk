//
//  FieldBlogImage.h
//  SampleApp
//
//  Created by Oleh Semenyshyn on 5/19/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <DrupalLib/DrupalEntity.h>

@interface FieldBlogImage : DrupalEntity
@property (strong, nonatomic) id target_id;
@property (strong, nonatomic) id display;
@property (strong, nonatomic) id description;
@property (strong, nonatomic) id alt;
@property (strong, nonatomic) id title;
@property (strong, nonatomic) id width;
@property (strong, nonatomic) id height;

@end
