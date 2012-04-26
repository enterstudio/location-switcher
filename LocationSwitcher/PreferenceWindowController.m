//
//  PreferenceWindowController.m
//  LocationSwitcher
//
//  Created by Adam O'Byrne on 26/04/12.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "PreferenceWindowController.h"

@interface PreferenceWindowController ()

@end

@implementation PreferenceWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    NSString * appPath = [[NSBundle mainBundle] bundlePath];
    
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	if ([self loginItemExistsWithLoginItemReference:loginItems ForPath:appPath]) {
		[btnToggleLoginItem setState:NSOnState];
	}
}

- (IBAction)toggleLoginItem:(id)sender
{
    NSLog(@"toggleLoginItem");
    
    NSString * appPath = [[NSBundle mainBundle] bundlePath];
	
	// Create a reference to the shared file list.
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		if ([sender state] == NSOnState)
			[self enableLoginItemWithLoginItemsReference:loginItems ForPath:appPath];
		else
			[self disableLoginItemWithLoginItemsReference:loginItems ForPath:appPath];
	}
}

- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath {
	// We call LSSharedFileListInsertItemURL to insert the item at the bottom of Login Items list.
	CFURLRef url = (__bridge CFURLRef)[NSURL fileURLWithPath:appPath];
	LSSharedFileListInsertItemURL(theLoginItemsRefs, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);		
}

- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath {
	UInt32 seedValue;
	CFURLRef thePath = NULL;
	// We're going to grab the contents of the shared file list (LSSharedFileListItemRef objects)
	// and pop it in an array so we can iterate through it to find our item.
	CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);
	for (id item in (__bridge NSArray *)loginItemsArray) {		
		LSSharedFileListItemRef itemRef = (__bridge LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &thePath, NULL) == noErr) {
			if ([[(__bridge NSURL *)thePath path] hasPrefix:appPath]) {
				LSSharedFileListItemRemove(theLoginItemsRefs, itemRef); // Deleting the item
			}
		}		
	}
}

- (BOOL)loginItemExistsWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString *)appPath {
	BOOL found = NO;  
	UInt32 seedValue;
	CFURLRef thePath = NULL;
	
	// We're going to grab the contents of the shared file list (LSSharedFileListItemRef objects)
	// and pop it in an array so we can iterate through it to find our item.
	CFArrayRef loginItemsArray = LSSharedFileListCopySnapshot(theLoginItemsRefs, &seedValue);
	for (id item in (__bridge NSArray *)loginItemsArray) {    
		LSSharedFileListItemRef itemRef = (__bridge LSSharedFileListItemRef)item;
		if (LSSharedFileListItemResolve(itemRef, 0, (CFURLRef*) &thePath, NULL) == noErr) {
			if ([[(__bridge NSURL *)thePath path] hasPrefix:appPath]) {
				found = YES;
				break;
			}
		}
	}
	
	return found;
}

@end
