//
//  VKDUser.h
//  VKDemo
//
//  Created by Valery Demin on 8/7/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import <Foundation/Foundation.h>

//[ESDDatabaseEntity(User)]
//[ESDSerializable]
@interface VKDUser : NSObject
//[ESDDatabaseAttribute(firstName)]
//[ESDSerializable(first_name)]
@property (nonatomic, strong) NSString* firstName;
//[ESDDatabaseAttribute(lastName)]
//[ESDSerializable(last_name)]
@property (nonatomic, strong) NSString* lastName;
//[ESDUniqueAttribute]
//[ESDDatabaseAttribute(uid)]
//[ESDSerializable(uid)]
@property (nonatomic, strong) NSNumber* uid;
//[ESDDatabaseAttribute(online)]
//[ESDSerializable(online)]
@property (nonatomic, strong) NSNumber* online;
//[ESDDatabaseAttribute(user_id)]
//[ESDSerializable(user_id)]
@property (nonatomic, strong) NSNumber* user_id;
//[ESDDatabaseAttribute(deactivated)]
//[ESDSerializable(deactivated)]
@property (nonatomic, strong) NSString* deactivated;
//[ESDDatabaseAttribute((photo))]
//[ESDSerializable(photo)]
@property (nonatomic, strong) NSString* photo;
//[ESDDatabaseAttribute(status)]
//[ESDSerializable(status)]
@property (nonatomic, strong) NSString* status;

//@property (nonatomic, readonly) BOOL hasStatus;
@end
