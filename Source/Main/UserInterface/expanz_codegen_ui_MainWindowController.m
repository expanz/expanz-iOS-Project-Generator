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


#import "expanz_codegen_ui_MainWindowController.h"
#import "expanz_codegen_model_ProcessStep.h"
#import "expanz_codegen_ui_ProjectLocationViewController.h"
#import "expanz_codegen_ui_ExpanzSettingsViewController.h"
#import "expanz_codegen_ui_ActivitySelectionViewController.h"
#import "expanz_codegen_model_UserSession.h"

@interface expanz_codegen_ui_MainWindowController (private)

- (void) setContentView:(NSView*)view;

@end
/* ================================================================================================================== */


@implementation expanz_codegen_ui_MainWindowController

@synthesize processStepsTableView = _processStepsTableView;
@synthesize currentStepViewContainer = _currentStepViewContainer;
@synthesize nextStepButton = _nextStepButton;
@synthesize previousStepButton = _previousStepButton;


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        _projectLocationViewController = [[ProjectLocationViewController alloc] initWithDelegate:self];
        _expanzSettingsViewController = [[ExpanzSettingsViewController alloc] initWithDelegate:self];
        _activitySelectionViewController = [[ActivitySelectionViewController alloc] initWithDelegate:self];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (expanz_codegen_model_ProcessStep*) currentStep {
    return _currentStep;
}


- (void) setCurrentStep:(expanz_codegen_model_ProcessStep*)currentStep {
    _currentStep = currentStep;
    [_nextStepButton setTitle:@"Next"];
    [_nextStepButton setAction:@selector(nextStep)];
    if (_currentStep == [ProcessStep projectLocation]) {
        [self setContentView:_projectLocationViewController.view];
        [_previousStepButton setEnabled:NO];
        [_nextStepButton setEnabled:YES];
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
    else if (_currentStep == [ProcessStep expanzSettings]) {
        [self setContentView:_expanzSettingsViewController.view];
        [_previousStepButton setEnabled:YES];
        [_nextStepButton setEnabled:NO];
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
        if ([_expanzSettingsViewController configFilesNeedLoading]) {
            [_expanzSettingsViewController populateExpanzBackendCombo];
        }
        [_expanzSettingsViewController populateSiteList];
    }
    else if (_currentStep == [ProcessStep activities]) {
        [self setContentView:_activitySelectionViewController.view];
        [_activitySelectionViewController populateActivityList];
        [_previousStepButton setEnabled:YES];
        [_nextStepButton setEnabled:NO];
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:2] byExtendingSelection:NO];
        [_activitySelectionViewController.activityTableView deselectAll:self];
    }
}

- (void) previousStep {
    NSUInteger currentStepIndex = [[ProcessStep allSteps] indexOfObject:_currentStep];
    if (currentStepIndex != 0) {
        ProcessStep* previousStep = [[ProcessStep allSteps] objectAtIndex:currentStepIndex - 1];
        [self setCurrentStep:previousStep];
    }
}

- (void) nextStep {
    NSUInteger currentStepIndex = [[ProcessStep allSteps] indexOfObject:_currentStep];
    if (currentStepIndex + 1 <= [[ProcessStep allSteps] count]) {
        ProcessStep* nextStep = [[ProcessStep allSteps] objectAtIndex:currentStepIndex + 1];
        [self setCurrentStep:nextStep];
    }
}

- (void) generate {
    [_activitySelectionViewController generateSelectedActivities];
}


- (void) windowDidLoad {
    [super windowDidLoad];
    [_previousStepButton setAction:@selector(previousStep)];
    [_nextStepButton setAction:@selector(nextStep)];
    [_processStepsTableView reloadData];
    NSString* const projectFilePath = [[UserSession sharedUserSession] projectFilePath];
    if (projectFilePath.length > 0) {
        [_projectLocationViewController setSelectedProjectFilePath:projectFilePath];
        [self setCurrentStep:[ProcessStep expanzSettings]];
    }
    else {
        [self setCurrentStep:[ProcessStep projectLocation]];
    }
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark NSTableView methods
- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
    return [[ProcessStep allSteps] count];
}

- (NSView*) tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
    ProcessStep* processStep = [[ProcessStep allSteps] objectAtIndex:row];
    NSString* identifier = [tableColumn identifier];

    NSTableCellView* cellView;
    if ([identifier isEqualToString:@"MainCell"]) {
        cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = processStep.stepName;
        cellView.imageView.objectValue = [[NSBundle mainBundle] imageForResource:processStep.imageResourceName];
    }
    return cellView;
}

/* ================================================================================================================== */
#pragma mark expanz_codegen_ui_EventHandler

- (void) didSelectSite {
    [_nextStepButton setEnabled:YES];
}

- (void) didSelectActivity {
    [_nextStepButton setTitle:@"Go!"];
    [_nextStepButton setEnabled:YES];
    [_nextStepButton setAction:@selector(generate)];
}

/* ================================================== Private Methods =============================================== */
- (void) setContentView:(NSView*)view {
    [_currentContentView removeFromSuperview];
    [_currentStepViewContainer addSubview:view];
    _currentContentView = view;

    CALayer* viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0)];
    [viewLayer setBorderWidth:1.0];
    [viewLayer setBorderColor:CGColorCreateGenericRGB(0.694, 0.694, 0.694, 1.0)];
    [view setWantsLayer:YES];
    [view setLayer:viewLayer];
}

@end