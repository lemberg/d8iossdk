//
//  DrupalEntity+Properties.h
//  DrupalLib
//
//  Created by Oleg Stasula on 19.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "DrupalEntity.h"


@interface DrupalEntity (Properties)

- (NSArray *)allProperties;
- (Class)classOfProperty:(NSString *)propertyName;

@end
