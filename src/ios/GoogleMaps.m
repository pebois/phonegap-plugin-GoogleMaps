//  GoogleMaps.m
//
//  Created by Pierre-Emmanuel Bois on 8/9/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "GoogleMaps.h"
#import "GoogleMapsViewController.h"

#import <Cordova/CDV.h>

@implementation GoogleMaps

- (void)addMarkers:(CDVInvokedUrlCommand*)command
{
    callbackId = command.callbackId;
    NSMutableArray* markers = [command.arguments objectAtIndex:0];
    if (markers != nil && markers.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
                if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
                    googleMapsViewController = [[GoogleMapsViewController alloc] initWithNibName:@"GoogleMapsViewControllerIpadPortrait" bundle:nil];
                } else {
                    googleMapsViewController = [[GoogleMapsViewController alloc] initWithNibName:@"GoogleMapsViewControllerIpadLandscape" bundle:nil];

                }
            } else {
                if ([[UIScreen mainScreen] bounds].size.height == 568) {
                    googleMapsViewController = [[GoogleMapsViewController alloc] initWithNibName:@"GoogleMapsViewControllerIphone5" bundle:nil];
                } else {
                    googleMapsViewController = [[GoogleMapsViewController alloc] initWithNibName:@"GoogleMapsViewController" bundle:nil];
                }
            }
            [googleMapsViewController setPlugin:self];
            [googleMapsViewController setCommand:command];
            [googleMapsViewController setMarkers:markers];
            googleMapsViewController.view.alpha = 0.f;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.5];
            googleMapsViewController.view.alpha = 1.f;
            [[[self viewController] view] addSubview:googleMapsViewController.view];
            [UIView commitAnimations];
        });
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)close:(CDVInvokedUrlCommand*)command
{
    [googleMapsViewController close:nil];
}

@end
