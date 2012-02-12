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
#import <Foundation/Foundation.h>


@interface expanz_codegen_ui_ProjectLocationViewController : NSViewController

@property(nonatomic, strong) IBOutlet NSComboBox* projectLocationCombo;
@property(nonatomic, strong) IBOutlet NSButton* browseForProjectButton;

- (void) browseForProject;

- (void) setSelectedProjectFilePath:(NSString*)selectedProjectFilePath;

@end
/* ================================================================================================================== */
@compatibility_alias ProjectLocationViewController expanz_codegen_ui_ProjectLocationViewController;