//
//  BlogPost.m
//  SampleApp
//
//  Created by Oleg Stasula on 20.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "BlogPost.h"


@implementation BlogPost

- (NSString *)path {
    return [NSString stringWithFormat:@"node/%@", self.nid];
}

@end
