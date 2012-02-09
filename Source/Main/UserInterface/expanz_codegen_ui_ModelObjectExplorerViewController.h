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

@class expanz_codegen_model_ProcessStep;

@interface expanz_codegen_ui_ModelObjectExplorerViewController : NSWindowController<NSTableViewDataSource,
    NSTableViewDelegate>

@property(nonatomic, strong) IBOutlet NSTableView* processStepsTableView;
@property(nonatomic, strong, readonly) NSString* projectFilePath;

- (id) initWithProjectFilePath:(NSString*)projectFilePath;

- (void) setStep:(expanz_codegen_model_ProcessStep*)processStep;

@end

/* ================================================================================================================== */
@compatibility_alias ModelObjectExplorerViewController expanz_codegen_ui_ModelObjectExplorerViewController;