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
    
    if ([self hasPath]) {
        [self addPath];
    }
    
    if ([self hasMarkers]) {
        [self addMarkers];
        [self autoZoom];
    }
}

- (void)close:(id)sender
{
    self.view.alpha = 1.f;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    self.view.alpha = 0.f;
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
    [UIView commitAnimations];
    
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

- (void)setPath:(NSString *)encPath
{
    path_ = encPath;
}

- (BOOL)hasPath
{
    if (path_ != nil && path_.length > 0) {
        return TRUE;
    }
    return FALSE;
}

- (void)addPath
{
    GMSPath *path = [GMSPath pathFromEncodedPath:path_];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 8.f;
    polyline.map = GoogleMapsView;
}

- (void)setMarkers:(NSMutableArray *)markersArray
{
    markers_ = markersArray;
}

- (BOOL)hasMarkers
{
    if (markers_ != nil && markers_.count > 0) {
        return TRUE;
    }
    return FALSE;
}

- (void)addMarkers
{
    GMSMarker *marker;
    for (int a = 0; a<markers_.count; a++)
    {
        NSDictionary *markerInfo = [markers_ objectAtIndex:a];
        marker = [self addMarker:markerInfo
                            name:[markerInfo objectForKey:@"title"]
                         snippet:[markerInfo objectForKey:@"subtitle"]
                        latitude:[[markerInfo objectForKey:@"latitude"] doubleValue]
                       longitude:[[markerInfo objectForKey:@"longitude"] doubleValue]];
    }
    if ([self hasPath] && marker != nil) {
        GoogleMapsView.selectedMarker = marker;
    }
    
}

- (GMSMarker *)addMarker:(id)markerInfo name:(NSString *)name snippet:(NSString *)snippet latitude:(double)latitude longitude:(double)longitude
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.userData = markerInfo;
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = name;
    marker.snippet = snippet;
    NSString *color = [markerInfo objectForKey:@"color"];
    if ([color isEqual:@"black"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor blackColor]];
    } else if ([color isEqual:@"blue"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor blueColor]];
    } else if ([color isEqual:@"brown"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor brownColor]];
    } else if ([color isEqual:@"cyan"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor cyanColor]];
    } else if ([color isEqual:@"darkgray"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor darkGrayColor]];
    } else if ([color isEqual:@"gray"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor grayColor]];
    } else if ([color isEqual:@"green"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    } else if ([color isEqual:@"lightgray"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor lightGrayColor]];
    } else if ([color isEqual:@"magenta"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor magentaColor]];
    } else if ([color isEqual:@"orange"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor orangeColor]];
    } else if ([color isEqual:@"purple"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
    } else if ([color isEqual:@"red"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
    } else if ([color isEqual:@"white"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor whiteColor]];
    } else if ([color isEqual:@"yellow"]) {
        marker.icon = [GMSMarker markerImageWithColor:[UIColor yellowColor]];
    }
    marker.animated = YES;
    marker.map = GoogleMapsView;
    if (bounds_ == nil) {
        bounds_ = [[GMSCoordinateBounds alloc] initWithCoordinate:marker.position coordinate:marker.position];
    }
    bounds_ = [bounds_ includingCoordinate:marker.position];
    return marker;
}

- (void)autoZoom
{
    GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds_ withPadding:100.f];
    [GoogleMapsView moveCamera:update];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // ...
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    //NSLog(@"You tapped the InfoWindow Of Marker [id:%@]", [marker.userData objectForKey:@"id"]);
    if ([self hasPath] == FALSE) {
        NSString *js = [NSString stringWithFormat:@"GoogleMaps.markerTapped('%@');", [marker.userData objectForKey:@"id"]];
        [plugin writeJavascript:js];
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    //NSLog(@"You tapped the Marker [id:%@]", [marker.userData objectForKey:@"id"]);
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
    }
    return YES;
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    //NSLog(@"You LongPressed at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    //NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}

@end
