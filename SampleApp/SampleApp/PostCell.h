//
//  PostCell.h
//  SampleApp
//
//  Created by Oleg Stasula on 23.05.14.
//  Copyright (c) 2014 ls. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PostCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *postImageView;

@end
