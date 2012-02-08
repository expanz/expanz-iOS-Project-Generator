////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "AppDelegate.h"
#import "expanz_codegen_ui_ModelObjectExplorerViewController.h"
#import "expanz_codegen_utils_ConfigFileParser.h"

@implementation AppDelegate

@synthesize window = _window;

/* ================================================ Interface Methods =============================================== */
- (void) applicationDidFinishLaunching:(NSNotification*)aNotification {
    NSConnection* connection = [[NSConnection alloc] init];
    [connection registerName:@"expanz.Model-Object-Explorer"];

    NSArray* args = [[NSProcessInfo processInfo] arguments];
    NSString* projectFilePath;
    if ([args count] >= 2) {
        projectFilePath = [args objectAtIndex:1];
    }

    NSString* configFilePath = [[NSBundle mainBundle] pathForResource:@"ToolConfiguration" ofType:@"plist"];
    ConfigFileParser* parser = [[ConfigFileParser alloc] initWithFilePath:configFilePath];
    NSArray* processSteps = [parser processSteps];

    _explorerController =
        [[ModelObjectExplorerViewController alloc] initWithProjectFilePath:projectFilePath processSteps:processSteps];
    [_explorerController showWindow:self];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender {
    return YES;
}

@end
