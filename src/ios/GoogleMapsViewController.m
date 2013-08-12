//  GoogleMapsViewController.m
//
//  Created by Pierre-Emmanuel Bois on 8/9/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <GoogleMaps/GoogleMaps.h>
#import <Cordova/CDV.h>

#import "GoogleMapsViewController.h"

@implementation GoogleMapsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // ...
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GoogleMapsView.myLocationEnabled = YES;
    GoogleMapsView.settings.compassButton = YES;
    GoogleMapsView.settings.myLocationButton = YES;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:15
                                                              bearing:0
                                                         viewingAngle:0];
    
    [GoogleMapsView setCamera:camera];
    
    GoogleMapsView.delegate = self;

    UIButton* myLocationButton = (UIButton*)[[GoogleMapsView subviews] lastObject];
    CGRect frame = myLocationButton.frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frame.origin.x = -10;
        frame.origin.y = -5;
    } else {
        frame.origin.x = 5;
    }
    myLocationButton.frame = frame;
    
    UIImage *image = [UIImage imageNamed:@"button_close.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.userInteractionEnabled = YES;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [button setFrame:CGRectMake(20, 20, 46, 46)];
    } else {
        [button setFrame:CGRectMake(5, 5, 46, 46)];
    }
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close :) forControlEvents:UIControlEventTouchUpInside];
    [GoogleMapsView addSubview:button];
    
    if ([self hasMarkers]) {
        [self addMarkers];
        [self autoZoom];
    }
}
- (void)close:(id)sender
{
    [GoogleMapsView removeFromSuperview];
    [self.view removeFromSuperview];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
    [plugin.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)setPlugin:(CDVPlugin *)cdvPlugin
{
    plugin = cdvPlugin;
}

- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand
{
    command = cdvCommand;
}

- (void)setMarkers:(NSMutableArray *)markersArray
{
    markers = markersArray;
}

- (BOOL)hasMarkers
{
    if (markers != nil && markers.count > 0) {
        return TRUE;
    }
    return FALSE;
}

- (void)addMarkers
{
    for (int a = 0; a<markers.count; a++)
    {
        NSDictionary *markerInfo = [markers objectAtIndex:a];
        [self addMarker:markerInfo
                   name:[markerInfo objectForKey:@"title"]
                snippet:[markerInfo objectForKey:@"subtitle"]
               latitude:[[markerInfo objectForKey:@"latitude"] doubleValue]
              longitude:[[markerInfo objectForKey:@"longitude"] doubleValue]];
    }
    
}

- (void)addMarker:(id)markerInfo name:(NSString *)name snippet:(NSString *)snippet latitude:(double)latitude longitude:(double)longitude
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.userData = markerInfo;
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = name;
    marker.snippet = snippet;
    marker.animated = YES;
    marker.map = GoogleMapsView;
    if (bounds == nil) {
        bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:marker.position coordinate:marker.position];
    }
    bounds = [bounds includingCoordinate:marker.position];
}

- (void)autoZoom
{
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds withPadding:100.f];
    [GoogleMapsView moveCamera:update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // ...
}

#pragma mark - GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.f];
    
    GMSCameraPosition *camera = [[GMSCameraPosition alloc] initWithTarget:marker.position
                                                                     zoom:[[GoogleMapsView camera] zoom]
                                                                  bearing:0
                                                             viewingAngle:0];
    [mapView animateToCameraPosition:camera];
    [CATransaction commit];
    
    
    if (mapView.selectedMarker != marker) {
        return NO;
    } else {
        NSString *js = [NSString stringWithFormat:@"GoogleMaps.markerTapped('%@');", [marker.userData objectForKey:@"id"]];
        [plugin writeJavascript:js];
    }
    
    return YES;
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"You LongPressed at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

@end
