//
//  VKDRootViewController.m
//  VKDemo
//
//  Created by Valery Demin on 8/5/13.
//  Copyright (c) 2013 Valery Demin. All rights reserved.
//

#import "VKDRootViewController.h"
#import "ESDWebServiceClient+VKDemoAPI.h"
#import "VKDUserWrapper.h"
#import "VKDUserCell.h"
#import "VKDDetailViewController.h"
#import <Spark/SparkDAO.h>
#import "VKDUIAssistance.h"
#import "VKDAuthenticationProvider.h"

static NSString* const VKD_CLIENT_APP_ID = @"3818309"; // id of application in vk.com
static NSString* const VKD_PERMISSIONS_FOR_APP = @"friends"; // frends, status, audio, video ...
static NSString* const VKD_REDIRECT_URL = @"https://oauth.vk.com/blank.html"; // Url for redirect after seccessful authentication
static NSString* const VKD_TYPE_OF_APP = @"mobile"; // page, popup, mobile
static NSString* const VKD_RESPONSE_TYPE = @"token";
static NSString* const VKD_SERVICE_ROOT_URL = @"https://api.vk.com/method/";
static NSString* const VKD_KEY_FOR_ACCESS_TOKEN_FROM_RESPONSE = @"access_token";
static NSString* const VKD_URL_FOR_REQUEST_TOKEN = @"https://oauth.vk.com/authorize";

@interface VKDRootViewController () <UIWebViewDelegate, UITableViewDataSource> {
    ESDWebServiceClient* _configuredClient;
    ESDDatabaseManager* _databaseManager;
    
    IBOutlet UITableView* _tableViewUsers;
    IBOutlet UIWebView* _webView;
    IBOutlet UILabel* _labelHeader;
    
    NSString* _accessToken;
    NSString* _userID;
    
    NSArray* _users;
}
@property (nonatomic, readonly) ESDDatabaseManager *databaseManager;
- (IBAction)buttonLoadFromDatabaseClick:(id)sender;
- (IBAction)buttonLoadFromVKClick:(id)sender;
- (ESDDatabaseManager*)databaseManager;
- (void)loadRequestForGettingTocken;
- (void)saveDataToStore;
@end

@implementation VKDRootViewController

#pragma mark - UIViewController cycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableViewUsers.hidden = YES;
    
    [self loadRequestForGettingTocken];
}

#pragma mark - Private methods

- (void)loadRequestForGettingTocken
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&scope=%@&redirect_uri=%@&display=%@&response_type=%@", VKD_URL_FOR_REQUEST_TOKEN, VKD_CLIENT_APP_ID, VKD_PERMISSIONS_FOR_APP, VKD_REDIRECT_URL, VKD_TYPE_OF_APP, VKD_RESPONSE_TYPE]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
}

- (ESDDatabaseManager*)databaseManager
{
    if (_databaseManager == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSString *basePath = [bundle resourcePath];
        basePath = [basePath stringByAppendingString:@"/VKDStorage.sqlite"];
        NSURL *storeUrl = [NSURL fileURLWithPath:basePath isDirectory:NO];
        _databaseManager = [[ESDDatabaseManager alloc] initWithModelNamed:@"VKDModel" storeUrl:storeUrl];
    }
    return _databaseManager;
}

- (void)saveDataToStore
{
    ESDDatabaseManager* databaseManager = self.databaseManager;
    
    for (VKDUser* user in _users) {
        ESDEntityMapper *entityMapper = [[ESDEntityMapper alloc] initWithContext:[databaseManager mainContext]];
        [entityMapper entityValueOfObject:user];
    }

    //Saving entity
    NSError *error = nil;
    [[databaseManager mainContext] save:&error];
    if (error != nil) {
        NSLog(@"Saving entity into storage failed with error: %@", error);
    } else {
        [VKDUIAssistance showLabelWithTextInCenterOfScreen:[NSString stringWithFormat:@"Load completed!\n%d items has been loaded from vk.com and has been saved in local database", [_users count]]];
    }
}

- (void)loadDataFromStore
{
    ESDDatabaseManager* databaseManager = self.databaseManager;

    VKDUser* userObject = [[VKDUser alloc] init];
    ESDDomainWrapper* domainWrapper = [[ESDDomainWrapper alloc] initWithObject:userObject];

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"status != nil"];
    NSArray* users = [ESDEntityFetcher fetchExistingEntities:domainWrapper onContext:[databaseManager mainContext] withPredicate:predicate];
    
    if ([users count] > 0) {
        _users = users;
        [self loadTable];
        [VKDUIAssistance showLabelWithTextInCenterOfScreen:[NSString stringWithFormat:@"Load completed!\n%d items has been loaded from local database", [_users count]]];
    }
}

- (void)logErrorFromResponse:(NSError*)error
{
    NSLog(@"%@", error);
    NSData *recievedData = [error.userInfo objectForKey:@"RecievedData"];
    NSString *recievedString = [[NSString alloc] initWithData:recievedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", recievedString);
}

- (void)loadTable
{
    _tableViewUsers.hidden = NO;
    [_tableViewUsers reloadData];
}

- (void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - IBActions

- (IBAction)buttonLoadFromDatabaseClick:(id)sender
{
    [self loadDataFromStore];
}

- (IBAction)buttonLoadFromVKClick:(id)sender
{
    if (_accessToken == nil) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You should wait for valid token from VK.COM" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alert show];
    }
    [_configuredClient loadListOfFriendsWithCompletitionBlock:^(VKDUserWrapper* userWrapper, NSError *error) {
        if (userWrapper) {
            if (userWrapper.error != nil) {
                NSLog(@"%@", userWrapper.error);
            } else {
                _users = userWrapper.usersWithStatus;
                [self loadTable];
                [_configuredClient loadPhotoForFriendsWithCompletitionBlock:^(VKDUserWrapper* userWrapper, NSError *error) {
                    if (userWrapper) {
                        for (VKDUser* userWithoutPhoto in _users) {
                            VKDUser* userWithPhoto = [userWrapper userByUid:userWithoutPhoto.uid];
                            userWithoutPhoto.photo = userWithPhoto.photo;
                        }
                        [_tableViewUsers reloadData];
                        [self saveDataToStore];
                    }
                }];
            }
        } else {
            [self logErrorFromResponse:error];
        }
    }];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* absoluteStringForURL = [[request URL] absoluteString];
    NSRange rangeForAccessToken = [absoluteStringForURL rangeOfString:VKD_KEY_FOR_ACCESS_TOKEN_FROM_RESPONSE];
    if (rangeForAccessToken.length > 0) {
        NSArray* componentsOfURL = [absoluteStringForURL componentsSeparatedByString:@"="];
        
        _accessToken = [[[componentsOfURL objectAtIndex:1] componentsSeparatedByString:@"&"] objectAtIndex:0];
        _userID = [componentsOfURL objectAtIndex:([componentsOfURL count] - 1)];
        
        _configuredClient = [[ESDWebServiceClient alloc] initWithServiceRoot:VKD_SERVICE_ROOT_URL];
        _configuredClient.authenticationProvider = [[VKDAuthenticationProvider alloc] initWithAccessToken:_accessToken];        
        [_configuredClient loadUserProfileForUID:_userID completitionBlock:^(VKDUserWrapper* userWrapper, NSError *error) {
            if (userWrapper) {
                VKDUser* user = [userWrapper.users objectAtIndex:0]; // get accaunt's owner
                _labelHeader.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
                _webView.hidden = YES;
            } else {
                [self logErrorFromResponse:error];
            }
        }];
        return NO;
    }

    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellID = @"VKDUserCell";
    VKDUserCell* cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[VKDUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.user = [_users objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UIViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"PushVKDDetailViewController"]) {
        VKDDetailViewController *detailViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [_tableViewUsers indexPathForCell:sender];
        VKDUser *selectedUser = [_users objectAtIndex:[indexPath row]];
        
        [detailViewController setUser:selectedUser];
    }
}

@end
