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


@implementation expanz_codegen_ui_ProjectLocationViewController

@synthesize projectLocationCombo = _projectLocationCombo;
@synthesize browseForProjectButton = _browseForProjectButton;

/* ================================================ Interface Methods =============================================== */
- (void) browseForProject {
    LogDebug(@"Need to implement browse for project action.");
}

- (void) setSelectedProjectFilePath:(NSString*)selectedProjectFilePath {
    NSInteger indexOfSelectedFilePath = [_projectLocationCombo indexOfItemWithObjectValue:selectedProjectFilePath];
    if (indexOfSelectedFilePath == NSNotFound) {
        [_projectLocationCombo addItemWithObjectValue:selectedProjectFilePath];
        [_projectLocationCombo selectItemAtIndex:[[_projectLocationCombo objectValues] count]];
    }
    else {
        [_projectLocationCombo selectItemAtIndex:[[_projectLocationCombo objectValues] count]];
    }
}


- (void) awakeFromNib {
    [super awakeFromNib];
    [_browseForProjectButton setAction:@selector(browseForProject)];
}


@end