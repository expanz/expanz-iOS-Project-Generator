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

@implementation AppDelegate

@synthesize window = _window;

- (void) applicationDidFinishLaunching:(NSNotification*)aNotification {
    NSConnection* connection = [[NSConnection alloc] init];
    [connection registerName:@"expanz.Model-Object-Explorer"];

    ModelObjectExplorerViewController* viewController =
        [[ModelObjectExplorerViewController alloc] initWithNibName:@"ModelObjectExplorer" bundle:[NSBundle mainBundle]];

    NSView* superView = self.window.contentView;
    [superView setAutoresizesSubviews:YES];
    [viewController.view setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
//    NSLog(@"subview's frame before resizing: %@", NSStringFromRect([viewController.view frame]));
//    [superView setFrame:NSMakeRect(0, 0, 200, 100)];
//    NSLog(@"subview's frame after  resizing: %@", NSStringFromRect([viewController.view frame]));
    
    [self.window.contentView addSubview:viewController.view];


}

@end
