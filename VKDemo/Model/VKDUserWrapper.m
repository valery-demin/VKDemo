//
//  VKDUserWrapper.m
//  VKDemo
//
//  Created by Valery Demin on 8/7/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDUserWrapper.h"

@implementation VKDUserWrapper

- (NSArray*)usersWithStatus
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(status != \"\") AND (deactivated != \"deleted\") AND (deactivated != \"banned\")"];
    return [self.users filteredArrayUsingPredicate:predicate];
}

- (VKDUser*)userByUid:(NSNumber*)uid
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"(uid == %d)", [uid integerValue]];
    return [[self.users filteredArrayUsingPredicate:predicate] objectAtIndex:0];
}

@end
