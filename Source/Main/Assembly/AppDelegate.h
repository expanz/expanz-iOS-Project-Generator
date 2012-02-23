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

#import <Cocoa/Cocoa.h>

@class expanz_codegen_ui_MainWindowController;

@interface AppDelegate : NSObject<NSApplicationDelegate>

@property(nonatomic, strong) NSWindow* window;
@property(nonatomic, strong) expanz_codegen_ui_MainWindowController* windowController;

@end
