//
//  TESTAppDelegate.m
//  TEST
//
//  Created by Joshua Garnham on 09/10/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TESTAppDelegate.h"

@implementation TESTAppDelegate

@synthesize window;

- (void)openApp {
	[[NSWorkspace sharedWorkspace] openFile:[path stringValue] withApplication:[appList objectAtIndex:[apps clickedRow]] andDeactivate:YES];
}

- (void)cancel {
	[appIcons removeAllObjects];
	[appList removeAllObjects];
	
	[path setEnabled:YES];
	[path setStringValue:@""];
	
	[count setStringValue:@""];
	[name setStringValue:@""];
	
	[checkAction setTitle:@"Check"];
	[checkAction setAction:@selector(checkForApps:)];
	
	[apps reloadData];
}

- (NSArray *)applicationsForURL:(NSURL *)url {
	return [(NSArray *)LSCopyApplicationURLsForURL((CFURLRef)url, kLSRolesAll) autorelease];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[[count cell] setBackgroundStyle:NSBackgroundStyleRaised];
	[apps setDoubleAction:@selector(openApp)];
	appList = [[NSMutableArray alloc] init];
	appIcons = [[NSMutableArray alloc] init];
}

- (IBAction)checkForApps:(id)sender {	
	NSURL *url = [NSURL fileURLWithPath:path.stringValue];
	NSArray *applications = [self applicationsForURL:url];
	for (NSURL *app in applications) {
		NSImage *icon = [[NSWorkspace sharedWorkspace] iconForFile:[app path]];
		[appIcons addObject:icon];
		[appList addObject:[app lastPathComponent]];
	}

	[name setStringValue:[url lastPathComponent]];
	[count setStringValue:[NSString stringWithFormat:@"There are %i applications to open %@", appList.count, url.lastPathComponent]]; 
	
	[checkAction setTitle:NSLocalizedString(@"Cancel",nil)];
	[checkAction setAction:@selector(cancel)];
	[path setEnabled:NO];
	
	[apps reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
	return [appList count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	if ([[[aTableColumn headerCell] stringValue] isEqualToString:@"Icon"]) {
		return [appIcons objectAtIndex:rowIndex];
	}
	return [appList objectAtIndex:rowIndex];
}

@end