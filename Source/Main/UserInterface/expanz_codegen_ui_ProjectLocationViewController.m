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
#import "expanz_codegen_ui_ProjectLocationViewController.h"
#import "expanz_codegen_model_UserSession.h"
#import "expanz_codegen_ui_EventHandler.h"


@implementation expanz_codegen_ui_ProjectLocationViewController

@synthesize projectLocationCombo = _projectLocationCombo;
@synthesize browseForProjectButton = _browseForProjectButton;


/* ================================================== Initializers ================================================== */
- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate {
    self = [super initWithNibName:@"ProjectLocation" bundle:[NSBundle mainBundle]];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) browseForProject {
    LogDebug(@"Need to implement browse for project action.");
}

- (void) selectedProjectFileDidChange {
    NSString* projectFilePath = [_projectLocationCombo objectValueOfSelectedItem];
    [[UserSession sharedUserSession] setProjectFilePath:projectFilePath];
}


- (void) setSelectedProjectFilePath:(NSString*)selectedProjectFilePath {
    NSInteger indexOfSelectedFilePath = [_projectLocationCombo indexOfItemWithObjectValue:selectedProjectFilePath];
    if (indexOfSelectedFilePath == NSNotFound) {
        [_projectLocationCombo addItemWithObjectValue:selectedProjectFilePath];
        [_projectLocationCombo selectItemAtIndex:[[_projectLocationCombo objectValues] count] - 1];
    }
    else {
        [_projectLocationCombo selectItemAtIndex:indexOfSelectedFilePath];
    }
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [_browseForProjectButton setAction:@selector(browseForProject)];
    [_projectLocationCombo setAction:@selector(selectedProjectFileDidChange)];
}


@end