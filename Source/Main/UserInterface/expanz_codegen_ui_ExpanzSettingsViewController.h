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
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface expanz_codegen_ui_ExpanzSettingsViewController : NSViewController

@property(nonatomic, weak) IBOutlet NSComboBox* expanzBackendCombo;
@property(nonatomic, strong) NSString* projectFilePath;

- (NSString*) supportingFilesPath;

- (void) populateExpanzBackendCombo;

- (void) populateSiteList;

@end
/* ================================================================================================================== */
@compatibility_alias ExpanzSettingsViewController expanz_codegen_ui_ExpanzSettingsViewController;

