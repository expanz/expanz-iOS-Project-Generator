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
#import "expanz_codegen_ui_ExpanzSettingsViewController.h"

@implementation expanz_codegen_ui_ExpanzSettingsViewController

@synthesize projectFilePath = _projectFilePath;
@synthesize expanzBackendCombo = _expanzBackendCombo;


/* ================================================ Interface Methods =============================================== */
- (void) awakeFromNib {
    [super awakeFromNib];
    LogDebug(@"Set action");
    [_expanzBackendCombo setTarget:self];
    [_expanzBackendCombo setAction:@selector(populateSiteList)];
}

- (void) populateExpanzBackendCombo {
    [_expanzBackendCombo removeAllItems];
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSArray* supportingFiles = [fileManager contentsOfDirectoryAtPath:[self supportingFilesPath] error:nil];
    for (NSString* supportingFile in supportingFiles) {
        if ([supportingFile hasSuffix:@"_environment.xml"]) {
            [_expanzBackendCombo addItemWithObjectValue:supportingFile];
        }
    }
    [_expanzBackendCombo selectItemAtIndex:0];
    [self populateSiteList];
}

- (void) populateSiteList {
    LogDebug(@"Ok - now populate the site list with value: %@", [_expanzBackendCombo objectValueOfSelectedItem]);
}


- (NSString*) supportingFilesPath {
    return [[_projectFilePath stringByAppendingPathComponent:[_projectFilePath lastPathComponent]]
        stringByAppendingPathComponent:@"Supporting Files"];
}


@end