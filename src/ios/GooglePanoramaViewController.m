//  GooglePanoramaViewController.m
//
//  Created by Pierre-Emmanuel Bois on 8/20/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed

#import <GoogleMaps/GoogleMaps.h>
#import <Cordova/CDV.h>

#import "GooglePanoramaViewController.h"

@implementation GooglePanoramaViewController

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
    
    struct CGRect frame = ContainerView.frame;
    
    frame.size.width -= 10;
    frame.size.height -= 10;
    
    GMSPanoramaView *GooglePanoramaView = [GMSPanoramaView panoramaWithFrame:frame
                                                              nearCoordinate:location_];
    GooglePanoramaView.camera = camera_;
    GooglePanoramaView.delegate = self;
    
    [ContainerView addSubview:GooglePanoramaView];
    [GooglePanoramaView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
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
    [GooglePanoramaView addSubview:button];
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

- (void)setLocation:(NSMutableDictionary *)coord
{
    location_ = CLLocationCoordinate2DMake([[coord objectForKey:@"latitude"] doubleValue],
                                           [[coord objectForKey:@"longitude"] doubleValue]);
}

- (void)setCamera:(NSMutableDictionary *)opts
{
    camera_ = [GMSPanoramaCamera cameraWithHeading:[[opts objectForKey:@"heading"] doubleValue]
                                             pitch:[[opts objectForKey:@"pitch"] doubleValue]
                                              zoom:[[opts objectForKey:@"zoom"] doubleValue]];
}

- (void)setPlugin:(CDVPlugin *)cdvPlugin
{
    plugin = cdvPlugin;
}

- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand
{
    command = cdvCommand;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // ...
}

#pragma mark - GMSPanoramaViewDelegate

- (void)panoramaView:(GMSPanoramaView *)panoramaView
       didMoveCamera:(GMSPanoramaCamera *)camera {
    //NSLog(@"Camera: (%f,%f,%f)", camera.orientation.heading, camera.orientation.pitch, camera.zoom);
}

- (void)panoramaView:(GMSPanoramaView *)view
   didMoveToPanorama:(GMSPanorama *)panorama
      nearCoordinate:(CLLocationCoordinate2D)coordinate {
    //NSLog(@"didMoveToPanorama");
}

@end
