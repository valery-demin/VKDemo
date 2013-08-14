//
//  VKDUIAssistance.m
//  VKDemo
//
//  Created by Valery Demin on 8/12/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDUIAssistance.h"
#import <QuartzCore/QuartzCore.h>

@implementation VKDUIAssistance

+(void)showLabelWithTextInCenterOfScreen:(NSString*)text {
    UILabel* lblMessage = nil;
	UILabel* lblMessageWithText = nil;
    UIWindow* window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    NSUInteger margin = 15;
    
	if (lblMessage == nil) {
		lblMessage = [UILabel new];
		lblMessage.backgroundColor = [UIColor darkGrayColor];
		lblMessage.layer.cornerRadius = 7;
        
        [window addSubview:lblMessage];
	}
    if (lblMessageWithText == nil) {
        lblMessageWithText = [UILabel new];
		lblMessageWithText.textColor = [UIColor whiteColor];
		lblMessageWithText.backgroundColor = [UIColor clearColor];
		lblMessageWithText.font = [UIFont boldSystemFontOfSize:13.];
		lblMessageWithText.textAlignment = NSTextAlignmentCenter;
        
        [lblMessage addSubview:lblMessageWithText];
    }
    CGSize sizeForText = [text sizeWithFont:lblMessageWithText.font constrainedToSize:CGSizeMake(window.frame.size.width - 4 * margin, window.frame.size.height - 4 * margin) lineBreakMode:NSLineBreakByTruncatingMiddle];
    CGRect frame = CGRectMake((window.frame.size.width - sizeForText.width) / 2 - margin, (window.frame.size.height - sizeForText.height) / 2 - margin, sizeForText.width + 2* margin, sizeForText.height + 2 * margin);
    lblMessageWithText.numberOfLines = sizeForText.height / lblMessageWithText.font.lineHeight;
    lblMessage.frame = frame;
    lblMessageWithText.frame = CGRectMake(margin, margin, frame.size.width - 2 * margin, frame.size.height - 2 * margin);
    lblMessageWithText.text = text;
    lblMessage.hidden = NO;
	lblMessage.alpha = 1.;
    
    NSTimeInterval durationOfAnimation = 3.;
	[UIView animateWithDuration:durationOfAnimation
	                      delay:durationOfAnimation
	                    options:0
	                 animations:^(void) {
                         lblMessage.alpha = 0.f;
                     } completion:^(BOOL finished) {
                         [lblMessage removeFromSuperview];
                         [lblMessageWithText removeFromSuperview];
                     }];
}

@end
