//
//  AppDelegate.h
//  LocationSwitcher
//
//  Created by defuser on 11/01/12.
//  Copyright (c) 2012 Adam O'Byrne. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SystemConfiguration/SystemConfiguration.h>

#import "PreferenceWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSArray *locations;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    CFStringRef current;
    NSMenuItem *ipMenuItem;
    PreferenceWindowController *preferenceWindowController;
    NSWindow *preferenceWindow;
}

-(IBAction)selectLocation:(id)sender;
-(void)openNetworkLocations;
-(void)openPreferences;
-(void)changeLocation:(NSString*)aLocation;
-(void)updateIPAddress;

@property (assign) IBOutlet NSWindow *window;

@end
