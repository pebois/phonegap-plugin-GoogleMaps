//  GoogleMapsViewController.h
//
//  Created by Pierre-Emmanuel Bois on 8/9/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Cordova/CDV.h>

@interface GoogleMapsViewController : UIViewController <GMSMapViewDelegate> {
    NSString *path_;
    NSMutableArray *markers_;
    GMSCoordinateBounds *bounds_;
    CDVPlugin *plugin;
    CDVInvokedUrlCommand *command;
    IBOutlet GMSMapView *GoogleMapsView;
}

- (void)close:(id)sender;

- (void)setPlugin:(CDVPlugin *)cdvPlugin;
- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand;

- (void)setPath:(NSString *)encPath;
- (BOOL)hasPath;
- (void)addPath;

- (void)setMarkers:(NSMutableArray *)markers;
- (BOOL)hasMarkers;
- (void)addMarkers;
- (GMSMarker *)addMarker:(id)ref name:(NSString *)name snippet:(NSString *)snippet latitude:(double)latitude longitude:(double)longitude;
- (void)autoZoom;

@end
