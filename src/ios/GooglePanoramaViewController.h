//  GooglePanoramaViewController.h
//
//  Created by Pierre-Emmanuel Bois on 8/20/13.
//
//  Copyright 2012-2013 Pierre-Emmanuel Bois. All rights reserved.
//  MIT Licensed


#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Cordova/CDV.h>

@interface GooglePanoramaViewController : UIViewController <GMSPanoramaViewDelegate> {
    CLLocationCoordinate2D location_;
    GMSPanoramaCamera *camera_;
    CDVPlugin *plugin;
    CDVInvokedUrlCommand *command;
    IBOutlet UIView *ContainerView;
}

- (void)close:(id)sender;
- (void)setLocation:(NSMutableDictionary *)coord;
- (void)setCamera:(NSMutableDictionary *)opts;
- (void)setPlugin:(CDVPlugin *)cdvPlugin;
- (void)setCommand:(CDVInvokedUrlCommand *)cdvCommand;

@end
