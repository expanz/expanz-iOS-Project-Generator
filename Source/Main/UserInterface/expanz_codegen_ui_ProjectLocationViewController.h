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

@protocol expanz_codegen_ui_EventHandler;


@interface expanz_codegen_ui_ProjectLocationViewController : NSViewController {

@private

    id<expanz_codegen_ui_EventHandler> _delegate;
}

@property(nonatomic, strong) IBOutlet NSComboBox* projectLocationCombo;
@property(nonatomic, strong) IBOutlet NSButton* browseForProjectButton;

- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate;


- (void) browseForProject;

- (void) selectedProjectFileDidChange;

- (void) setSelectedProjectFilePath:(NSString*)selectedProjectFilePath;

@end
/* ================================================================================================================== */
@compatibility_alias ProjectLocationViewController expanz_codegen_ui_ProjectLocationViewController;