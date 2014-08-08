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
