//
//  PreferenceWindowController.h
//  LocationSwitcher
//
//  Created by Adam O'Byrne on 26/04/12.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceWindowController : NSWindowController {
    IBOutlet NSButton *btnToggleLoginItem;
}

- (IBAction)toggleLoginItem:(id)sender;
- (void)enableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (void)disableLoginItemWithLoginItemsReference:(LSSharedFileListRef )theLoginItemsRefs ForPath:(NSString *)appPath;
- (BOOL)loginItemExistsWithLoginItemReference:(LSSharedFileListRef)theLoginItemsRefs ForPath:(NSString *)appPath;

@end
