//
//  VKDUser.m
//  VKDemo
//
//  Created by Valery Demin on 8/7/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDUser.h"

@implementation VKDUser

@synthesize firstName;
@synthesize lastName;
@synthesize online;
@synthesize deactivated;
@synthesize status;
@synthesize photo;
@synthesize uid;
@synthesize user_id;

//- (BOOL)hasStatus
//{
//    return ([self.status length] > 0);
//}

- (NSString*)description
{
    return [NSString stringWithFormat:@"First name: %@ Last name: %@ Uid: %@", self.firstName, self.lastName, [self.uid stringValue]];
}

@end
