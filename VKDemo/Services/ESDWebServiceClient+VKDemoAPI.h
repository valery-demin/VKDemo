//
//  ESDWebServiceClient_VKDemoAPI.h
//  VKDemo
//
//  Created by Valery Demin on 8/5/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import <Spark/SparkWebService.h>
#import "VKDUserWrapper.h"

@class EFWODataAuthenticationResult;
@protocol ESDWebServiceCancellable;

//[ESDWebServiceClientStatusCodes(validCodes : [NSRange:{200, 100}])]
@interface ESDWebServiceClient (ODataRequests)

//[ESDWebServiceCall(defaultValue : getProfiles?uid=%%0%%)]
//[ESDWebServiceCall(method : GET)]
//[ESDWebServiceCache(cacheDisabled: yes)]
//[ESDWebServiceHeader(Accept: application/json)]
//[ESDWebServiceHeader(Content-Type: application/json)]
//[ESDWebServiceCall(prototypeClass : VKDUserWrapper)]
- (id<ESDWebServiceCancellable>)loadUserProfileForUID:(NSString *)uid completitionBlock:(void(^)(VKDUserWrapper* userWrapper, NSError *error))callbackBlock;

//[ESDWebServiceCall(defaultValue : friends.get?fields=status)]
//[ESDWebServiceCall(method : GET)]
//[ESDWebServiceCache(cacheDisabled: yes)]
//[ESDWebServiceHeader(Accept: application/json)]
//[ESDWebServiceHeader(Content-Type: application/json)]
//[ESDWebServiceCall(prototypeClass : VKDUserWrapper)]
- (id<ESDWebServiceCancellable>)loadListOfFriendsWithCompletitionBlock:(void(^)(VKDUserWrapper* userWrapper, NSError *error))callbackBlock;

//[ESDWebServiceCall(defaultValue : friends.get?fields=photo)]
//[ESDWebServiceCall(method : GET)]
//[ESDWebServiceCache(cacheDisabled: yes)]
//[ESDWebServiceHeader(Accept: application/json)]
//[ESDWebServiceHeader(Content-Type: application/json)]
//[ESDWebServiceCall(prototypeClass : VKDUserWrapper)]
- (id<ESDWebServiceCancellable>)loadPhotoForFriendsWithCompletitionBlock:(void(^)(VKDUserWrapper* userWrapper, NSError *error))callbackBlock;

@end
