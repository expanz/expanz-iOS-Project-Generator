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

static NSBundle* pluginBundle;

@interface expanz_codegen_PluginLoader : NSObject

+ (void) pluginDidLoad:(NSBundle*)plugin;

+ (void) applicationFinishedLaunching:(NSNotification*)notification;

@end