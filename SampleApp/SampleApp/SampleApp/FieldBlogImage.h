//
//  FieldBlogImage.h
//  SampleApp
//
//  Created by Oleh Semenyshyn on 5/19/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <DrupalLib/DrupalEntity.h>

@interface FieldBlogImage : DrupalEntity

@property (strong, nonatomic) NSString *target_id;
@property (strong, nonatomic) NSString *display;
@property (strong, nonatomic) NSString *alt;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *width;
@property (strong, nonatomic) NSString *height;

@end
