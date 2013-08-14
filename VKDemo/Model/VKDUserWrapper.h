//
//  VKDUserWrapper.h
//  VKDemo
//
//  Created by Valery Demin on 8/7/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKDUser.h"

//[ESDDatabaseEntity(UserWrapper)]
@interface VKDUserWrapper : NSObject
//[ESDSerializable(response)]
//[ESDSerializableCollection(VKDUser)]
//[ESDDatabaseRelation(users)]
@property (nonatomic, strong) NSArray* users;

//[ESDSerializable(error)]
@property (nonatomic, strong) id error;

@property (nonatomic, readonly) NSArray* usersWithStatus;

- (VKDUser*)userByUid:(NSNumber*)uid;
@end
