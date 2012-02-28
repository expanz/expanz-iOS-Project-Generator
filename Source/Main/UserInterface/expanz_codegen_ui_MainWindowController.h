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
@class expanz_codegen_ui_ProjectLocationViewController;
@class expanz_codegen_ui_ExpanzSettingsViewController;
@class expanz_codegen_ui_ActivitySelectionViewController;

@interface expanz_codegen_ui_MainWindowController : NSWindowController<NSTableViewDataSource, NSTableViewDelegate> {

@private
    NSView* _currentContentView;
    expanz_codegen_model_ProcessStep* _currentStep;
    expanz_codegen_ui_ProjectLocationViewController* _projectLocationViewController;
    expanz_codegen_ui_ExpanzSettingsViewController* _expanzSettingsViewController;
    expanz_codegen_ui_ActivitySelectionViewController* _activitySelectionViewController;
}

@property(nonatomic, weak) IBOutlet NSTableView* processStepsTableView;
@property(nonatomic, weak) IBOutlet NSView* currentStepViewContainer;
@property(nonatomic, weak) IBOutlet NSButton* nextStepButton;
@property(nonatomic, weak) IBOutlet NSButton* previousStepButton;

- (id) initWithProjectFilePath:(NSString*)projectFilePath;

- (expanz_codegen_model_ProcessStep*) currentStep;

- (void) setCurrentStep:(expanz_codegen_model_ProcessStep*)currentStep;

- (void) previousStep;

- (void) nextStep;

@end

/* ================================================================================================================== */
@compatibility_alias MainWindowController expanz_codegen_ui_MainWindowController;