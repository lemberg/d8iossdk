//
//  DrupalDictionary.h
//  DrupalLib
//
//  Created by Oleh Semenyshyn on 5/20/14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrupalDictionary : NSDictionary
@property (strong, readonly, nonatomic) Class orderClass;

- (id)initWithClass:(Class)classname;
@end
