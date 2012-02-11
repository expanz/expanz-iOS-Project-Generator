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
#import "../UserInterface/expanz_codegen_ui_MainWindowController.h"

@implementation AppDelegate

@synthesize window = _window;

/* ================================================ Interface Methods =============================================== */
- (void) applicationDidFinishLaunching:(NSNotification*)aNotification {
    NSConnection* connection = [[NSConnection alloc] init];
    [connection registerName:@"expanz.Model-Object-Explorer"];

    NSString* projectFilePath;
    NSArray* args = [[NSProcessInfo processInfo] arguments];
    for (NSString* arg in args) {
        if ([arg hasPrefix:@"-expanzProjectDirectory"]) {
            projectFilePath = [arg stringByReplacingOccurrencesOfString:@"-expanzProjectDirectory" withString:@""];
            projectFilePath =
                [projectFilePath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            projectFilePath = [projectFilePath stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            LogDebug(@"Project file path is: %@", projectFilePath);
        }
    }
    _windowController = [[MainWindowController alloc] initWithProjectFilePath:projectFilePath];
    [_windowController showWindow:self];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication*)sender {
    return YES;
}

@end
