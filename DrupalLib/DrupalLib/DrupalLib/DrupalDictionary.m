//
//  DrupalDictionary.m
//  DrupalLib
//
//  Created by Oleh Semenyshyn on 5/20/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalDictionary.h"

@implementation DrupalDictionary
@synthesize orderClass = _orderClass;

- (id)initWithClass:(Class)classname {
    if (self = [super init]) {
        _orderClass = classname;
    }
    
    return self;
}

- (Class)class {
    return _orderClass;
}

@end
