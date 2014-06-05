//
//  PostCell.m
//  SampleApp
//
//  Created by Oleg Stasula on 23.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import "PostCell.h"


@implementation PostCell

- (void)awakeFromNib
{
    self.titleLabel.numberOfLines = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 2 : 3;
    self.detailLabel.numberOfLines = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 3 : 2;
}


@end
