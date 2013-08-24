//  GoogleMaps.h
//
//  Created by Pierre-Emmanuel Bois on 8/9/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import "GoogleMapsViewController.h"
#import "GooglePanoramaViewController.h"

#import <Cordova/CDV.h>
#import <UIKit/UIKit.h>

@interface GoogleMaps : CDVPlugin {
    GoogleMapsViewController* googleMapsViewController;
    GooglePanoramaViewController* googlePanoramaViewController;
}

- (void)showMarkers:(CDVInvokedUrlCommand*)command;
- (void)showPath:(CDVInvokedUrlCommand*)command;
- (void)showPanorama:(CDVInvokedUrlCommand*)command;
- (void)close:(CDVInvokedUrlCommand*)command;

@end
