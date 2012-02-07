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

#import "expanz_codegen_ui_ModelObjectExplorerViewController.h"


@implementation expanz_codegen_ui_ModelObjectExplorerViewController


@synthesize projectFilePath = _projectFilePath;
@synthesize projectCombo = _projectCombo;
@synthesize browseProject = _browseProject;
@synthesize environmentCombo = _environmentCombo;
@synthesize locateEnvironment = _locateEnvironment;

/* ================================================== Initializers ================================================== */
- (id) initWithProjectFilePath:(NSString*)projectFilePath {
    //self = [super initWithNibName:@"ModelObjectExplorer" bundle:[NSBundle mainBundle]];
    if (self) {
        _projectFilePath = projectFilePath;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) awakeFromNib {
    [super awakeFromNib];
    LogDebug(@"Awoke from nib!");
}

- (IBAction) showWindow:(id)sender {
    [super showWindow:sender];
    LogDebug(@"Finished show window");
    [NSThread sleepForTimeInterval:10000000];
}


@end