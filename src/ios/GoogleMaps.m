//  GoogleMaps.m
//
//  Created by Pierre-Emmanuel Bois on 8/9/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "GoogleMaps.h"
#import "GoogleMapsViewController.h"
#import "GooglePanoramaViewController.h"

#import <Cordova/CDV.h>

@implementation GoogleMaps

- (void)addMarkers:(CDVInvokedUrlCommand*)command
{
    NSMutableArray* markers = [command.arguments objectAtIndex:0];
    if (markers != nil && markers.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            googleMapsViewController = [[GoogleMapsViewController alloc] initWithNibName:@"GoogleMapsViewController" bundle:nil];
            [googleMapsViewController setPlugin:self];
            [googleMapsViewController setCommand:command];
            [googleMapsViewController setMarkers:markers];
            googleMapsViewController.view.alpha = 0.f;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.3];
            googleMapsViewController.view.alpha = 1.f;
            [[[self viewController] view] addSubview:googleMapsViewController.view];
            [googleMapsViewController.view setFrame:self.webView.frame];
            [UIView commitAnimations];
        });
    } else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)showPanorama:(CDVInvokedUrlCommand*)command
{
    NSMutableDictionary* coord = [command.arguments objectAtIndex:0];
    NSMutableDictionary* opts = [command.arguments objectAtIndex:1];
    
    if (coord != nil && opts != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            googlePanoramaViewController = [[GooglePanoramaViewController alloc] initWithNibName:@"GooglePanoramaViewController" bundle:nil];
            [googlePanoramaViewController setPlugin:self];
            [googlePanoramaViewController setCommand:command];
            [googlePanoramaViewController setLocation:coord];
            [googlePanoramaViewController setCamera:opts];
            googlePanoramaViewController.view.alpha = 0.f;
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:.3];
            googlePanoramaViewController.view.alpha = 1.f;
            [[[self viewController] view] addSubview:googlePanoramaViewController.view];
            [googlePanoramaViewController.view setFrame:self.webView.frame];
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
    [googlePanoramaViewController close:nil];
}

@end
