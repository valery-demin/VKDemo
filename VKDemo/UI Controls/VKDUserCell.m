//
//  VKDUserCell.m
//  VKDemo
//
//  Created by Valery Demin on 8/8/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDUserCell.h"

@interface VKDUserCell () {
    IBOutlet UILabel* _labelName;
    IBOutlet UILabel* _labelOnline;
    IBOutlet UIImageView* _imageViewPhoto;
    IBOutlet UILabel* _labelStatus;
}

@end

@implementation VKDUserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(VKDUser *)user
{
    _labelName.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    _labelOnline.hidden = ([user.online integerValue] != 1);
    _labelStatus.text = user.status;
    NSData* dataForPhoto = [NSData dataWithContentsOfURL:[NSURL URLWithString:user.photo]];
    _imageViewPhoto.image = [UIImage imageWithData:dataForPhoto];
    [self setBackgroundColor:([user.online integerValue] == 1) ? [UIColor grayColor] : [UIColor whiteColor]];
}

@end
