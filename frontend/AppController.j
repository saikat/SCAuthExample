/*
 * AppController.j
 * SCAuthExample
 *
 * Created by Saikat Chakrabarti on April 7, 2010.
 *
 * See LICENSE file for license information.
 * 
 */

@import <Foundation/CPObject.j>
@import <Foundation/CPURLConnection.j>
// This is important
@import <SCAuth/SCUserSessionManager.j>

@implementation AppController : CPObject
{
    CPButton loginButton;
    CPButton logoutButton;
    CPButton unauthorizedActionButton;
    CPURLConnection authConnection;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
    // This is all layout code - not important
    loginButton = [CPButton buttonWithTitle:@"Login"];
    [loginButton setTarget:self];
    [loginButton setAction:@selector(login:)];

    logoutButton = [CPButton buttonWithTitle:@"Logout"];
    [logoutButton setTarget:self];
    [logoutButton setAction:@selector(logout:)];

    unauthorizedActionButton = [CPButton buttonWithTitle:@"Do something that requires authentication"];
    [unauthorizedActionButton setTarget:self];
    [unauthorizedActionButton setAction:@selector(unauthorizedAction:)];

    [contentView addSubview:loginButton];
    [contentView addSubview:logoutButton];
    [contentView addSubview:unauthorizedActionButton];
    [loginButton setCenter:CGPointMake([contentView center].x,
                                       [contentView center].y - 50.0)];
    [logoutButton setCenter:CGPointMake([contentView center].x,
                                       [contentView center].y - 10.0)];
    [unauthorizedActionButton setCenter:CGPointMake([contentView center].x,
                                                    [contentView center].y + 30.0)];
    [loginButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [unauthorizedActionButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [theWindow orderFront:self];
    // End of layout code
}

- (void)unauthorizedAction:(id)sender
{
    // Though there is no interaction here with SCUserSessionManager, SCUserSessionManager will
    // monitor the response to this request for 401s
    var request = [CPURLRequest requestWithURL:[CPURL URLWithString:@"/user/demo"]];
    [request setHTTPMethod:@"PUT"];
    authConnection = [CPURLConnection connectionWithRequest:request
                                               delegate:self];
    
}

- (void)alertWithMessage:(CPString)aMessage title:(CPString)aTitle
{
    var activationAlert = [[CPAlert alloc] init];
    [activationAlert setTitle:aTitle];
    [activationAlert setAlertStyle:CPInformationalAlertStyle];
    [activationAlert setMessageText:aMessage];
    [activationAlert addButtonWithTitle:@"Ok"];
    [activationAlert runModal];
}

- (void)successfulAlertWithMessage:(CPString)aMessage
{
    [self alertWithMessage:aMessage title:@"Success!"];
}

- (void)failureAlertWithMessage:(CPString)aMessage
{
    [self alertWithMessage:aMessage title:@"Failed!"];
}

- (void)connection:(CPURLConnection)connection didReceiveResponse:(CPURLResponse)aResponse
{
    if (![aResponse isKindOfClass:[CPHTTPURLResponse class]])
        return;

    if (connection === authConnection && [aResponse statusCode] === 200)
        [self successfulAlertWithMessage:@"You did something that required authentication successfully!"];
}

- (void)connection:(CPURLConnection)connection didFailWithError:(CPError)anError
{
    if (connection === authConnection)
        [self failureAlertWithMessage:@"You failed to do something that required authentication!"];
}

- (void)loginDidSucceed:(SCUserSessionManager)sessionManager
{
    [self successfulAlertWithMessage:@"You logged in successfully!"];
}

- (void)logoutDidSucceed:(SCUserSessionManager)sessionManager
{
    [self successfulAlertWithMessage:@"You logged out successfully!"];
} 

- (void)logout:(id)sender
{
    [[SCUserSessionManager defaultManager] logout:self];
}

- (void)login:(id)sender
{
    [[SCUserSessionManager defaultManager] login:self];
}
@end
