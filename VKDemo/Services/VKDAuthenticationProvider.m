//
//  VKDAuthenticationProvider.m
//  VKDemo
//
//  Created by Valery Demin on 8/12/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDAuthenticationProvider.h"

static NSString* const VKD_KEY_FOR_ACCESS_TOKEN_FROM_RESPONSE = @"access_token";

@interface VKDAuthenticationProvider () {
    NSString* _accessToken;
}
@end

@implementation VKDAuthenticationProvider

- (id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        _accessToken = accessToken;
    }
    return self;
}

- (void)checkResponse:(NSURLResponse *)response forConnection:(NSURLConnection *)connection {
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    int errorCode = httpResponse.statusCode;
    NSLog(@"StatusCode: %d for response for URL:%@", errorCode, [[httpResponse URL] absoluteString]);
}

- (void)addAuthenticationDataToRequest:(NSMutableURLRequest *)request {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@=%@", [[request URL] absoluteString], VKD_KEY_FOR_ACCESS_TOKEN_FROM_RESPONSE, _accessToken]];
    [request setURL:url];
}

@end
