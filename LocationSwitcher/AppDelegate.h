//
//  AppDelegate.h
//  LocationSwitcher
//
//  Created by defuser on 11/01/12.
//  Copyright (c) 2012 Adam O'Byrne. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSArray *locations;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    CFStringRef current;
}

-(IBAction)selectLocation:(id)sender;
-(void)changeLocation:(NSString*)aLocation;

@property (assign) IBOutlet NSWindow *window;

@end
