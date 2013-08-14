//
//  VKDDetailViewController.m
//  VKDemo
//
//  Created by Valery Demin on 8/8/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDDetailViewController.h"

@interface VKDDetailViewController () {
    IBOutlet UILabel* _labelFirstName;
    IBOutlet UILabel* _labelLastName;
    IBOutlet UILabel* _labelOnline;
    IBOutlet UIImageView* _imageViewPhoto;
    IBOutlet UILabel* _labelStatus;
}
- (IBAction)buttonBackClick:(id)sender;
@end

@implementation VKDDetailViewController

@synthesize user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataForControls];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadDataForControls
{
    _labelFirstName.text = self.user.firstName;
    _labelLastName.text = self.user.lastName;
    _labelOnline.hidden = ([self.user.online integerValue] != 1);
    _labelStatus.text = self.user.status;
    NSData* dataForPhoto = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.photo]];
    _imageViewPhoto.image = [UIImage imageWithData:dataForPhoto];
}

@end
