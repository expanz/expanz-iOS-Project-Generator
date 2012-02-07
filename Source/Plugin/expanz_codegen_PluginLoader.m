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

#import <objc/runtime.h>
#import "expanz_codegen_PluginLoader.h"
#import "expanz_codegen_ui_ModelObjectExplorerViewController.h"

@implementation expanz_codegen_PluginLoader


+ (void) pluginDidLoad:(NSBundle*)bundle {

    NSLog(@"%@ initializing...", NSStringFromClass([self class]));

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationFinishedLaunching:)
                                                 name:NSApplicationDidFinishLaunchingNotification object:nil];

    pluginBundle = bundle;
    NSLog(@"%@ complete!", NSStringFromClass([self class]));
    return;
}

+ (void) applicationFinishedLaunching:(NSNotification*)notification {

    NSMenu* mainMenu = [NSApp mainMenu];
    NSMenuItem* viewMenuItem = [mainMenu itemWithTitle:@"View"];
    NSMenu* viewMenu = [viewMenuItem submenu];

    NSMenuItem* modelObjectExplorerMenuItem =
        [viewMenu addItemWithTitle:@"Model Object Explorer" action:@selector(showExplorer:) keyEquivalent:@"e"];

    [modelObjectExplorerMenuItem setKeyEquivalentModifierMask:(NSCommandKeyMask | NSShiftKeyMask)];
    [modelObjectExplorerMenuItem setTarget:self];

}


+ (void) showExplorer:(id)sender {
    NSString* className = @"IDEDocumentController";
    id clazz = objc_getClass([className cStringUsingEncoding:NSASCIIStringEncoding]);
    id documentController = [clazz sharedDocumentController];
    NSString* projectDirectory = [documentController currentDirectory];
    LogDebug(@"Project directory: %@", projectDirectory);

    NSURL* appUrl =
        [[NSWorkspace sharedWorkspace] URLForApplicationWithBundleIdentifier:@"expanz.Model-Object-Explorer"];
    NSWorkspace* ws = [NSWorkspace sharedWorkspace];

    NSArray* initParams = [NSArray arrayWithObjects:projectDirectory, nil];

    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:initParams forKey:NSWorkspaceLaunchConfigurationArguments];

    [ws launchApplicationAtURL:appUrl options:NSWorkspaceLaunchDefault configuration:dict error:nil];
}


@end