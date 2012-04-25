//
//  AppDelegate.m
//  LocationSwitcher
//
//  Created by defuser on 11/01/12.
//  Copyright (c) 2012 Adam O'Byrne. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>

@implementation AppDelegate

@synthesize window = _window;

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
 
}

-(void)awakeFromNib
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@"x"];
    [statusItem setHighlightMode:YES];
    [statusItem setEnabled:YES];
    
//    [[statusMenu addItemWithTitle:@"Network Locations" action:@selector(terminate:) keyEquivalent:@""] setEnabled:FALSE];
//    [statusMenu addItem: [NSMenuItem separatorItem]];
    
    SCPreferencesRef prefs = SCPreferencesCreate(NULL, (CFStringRef)@"SystemConfiguration", NULL);
    locations = (__bridge NSArray *)SCNetworkSetCopyAll(prefs);
    
    int count = 0;
    for (id location in locations)
    {
        count++;
        NSString *title = (__bridge NSString *)SCNetworkSetGetName((__bridge SCNetworkSetRef)location);
        [statusMenu addItemWithTitle:title action:@selector(selectLocation:) keyEquivalent:[[NSNumber numberWithInt:count] stringValue]];
    }
    
    [statusMenu addItem: [NSMenuItem separatorItem]];
    [statusMenu addItemWithTitle:@"Preferences" action:@selector(openSystemPreference:) keyEquivalent:@"p"];
    
    [statusMenu addItem: [NSMenuItem separatorItem]];
    [statusMenu addItemWithTitle:@"Quit" action:@selector(terminate:) keyEquivalent:@"q"];
    
    current = SCNetworkSetGetName(SCNetworkSetCopyCurrent(prefs));
    [[statusMenu itemWithTitle:(__bridge NSString*)current] setEnabled:FALSE];
    
    [statusItem setTarget:self];
    [statusItem setAction:@selector(selectLocation:)];
}

-(void)openSystemPreference:(NSString*)aLocation
{
    [[NSWorkspace sharedWorkspace] openFile:@"/System/Library/PreferencePanes/Network.prefPane"];
}

-(IBAction)selectLocation:(id)sender
{
    NSMenuItem *menuItem = (NSMenuItem*)sender;
    NSString *location = [menuItem title];
    [self changeLocation:location];
    
    for (id location in locations)
    {
        NSString *title = (__bridge NSString *)SCNetworkSetGetName((__bridge SCNetworkSetRef)location);
        [[statusMenu itemWithTitle:title] setEnabled:TRUE];
    }
    
    [menuItem setEnabled:FALSE];
}

-(void)changeLocation:(NSString*)aLocation
{
    NSTask *theProcess = [[NSTask alloc] init];

    [theProcess setLaunchPath:@"/usr/sbin/scselect"];
    [theProcess setArguments:[NSArray arrayWithObject:aLocation]];
    [theProcess launch];
}

@end
