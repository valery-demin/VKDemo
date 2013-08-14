//
//  VKDAuthenticationProvider.h
//  VKDemo
//
//  Created by Valery Demin on 8/12/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import <Spark/SparkWebservice.h>

@interface VKDAuthenticationProvider : ESDAuthenticationProvider
- (id)initWithAccessToken:(NSString *)accessToken;
@end
