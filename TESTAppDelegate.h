//
//  TESTAppDelegate.h
//  TEST
//
//  Created by Joshua Garnham on 09/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TESTAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSTextField *path;
	IBOutlet NSTableView *apps;
	NSMutableArray *appList;
	NSMutableArray *appIcons;
	IBOutlet NSTextField *count;
	IBOutlet NSTextField *name;
	IBOutlet NSButton *checkAction;
}

- (IBAction)checkForApps:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
