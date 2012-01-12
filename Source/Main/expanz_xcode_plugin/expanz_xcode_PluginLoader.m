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
#import "expanz_xcode_PluginLoader.h"

@implementation expanz_xcode_PluginLoader


+ (void) pluginDidLoad:(NSBundle*)bundle {

    NSLog(@"%@ initializing...", NSStringFromClass([self class]));

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationFinishedLaunching:)
                                                 name:NSApplicationDidFinishLaunchingNotification object:nil];

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
    NSWindow* activeWindow = [NSApp keyWindow];

    NSString* className = @"IDEDocumentController";
    id clazz = objc_getClass([className cStringUsingEncoding:NSASCIIStringEncoding]);
    id documentController = [clazz sharedDocumentController];


    id delegate = [activeWindow delegate];
    LogDebug(@"Delegate class: %@", [delegate class]);

    NSAlert* alert = [[NSAlert alloc] init];
    [alert setMessageText:[documentController currentDirectory]];
    [alert beginSheetModalForWindow:activeWindow modalDelegate:self
                     didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

+ (void) alertDidEnd:(NSAlert*)a returnCode:(NSInteger)rc contextInfo:(void*)ci {
    switch (rc) {
        case NSAlertFirstButtonReturn:
            // "First" pressed
            break;
        case NSAlertSecondButtonReturn:
            // "Second" pressed
            break;
            // ...
    }
}


@end