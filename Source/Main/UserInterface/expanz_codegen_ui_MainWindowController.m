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

@implementation expanz_codegen_ui_MainWindowController

@synthesize processStepsTableView = _processStepsTableView;
@synthesize currentStepViewContainer = _currentStepViewContainer;
@synthesize nextStepButton = _nextStepButton;
@synthesize previousStepButton = _previousStepButton;
@synthesize projectFilePath = _projectFilePath;
@synthesize projectLocationViewController = _projectLocationViewController;


/* ================================================== Initializers ================================================== */
- (id) initWithProjectFilePath:(NSString*)projectFilePath {
    self = [super initWithWindowNibName:@"MainWindow"];
    if (self) {
        _projectFilePath = [projectFilePath copy];
        _projectLocationViewController =
            [[ProjectLocationViewController alloc] initWithNibName:@"ProjectLocation" bundle:[NSBundle mainBundle]];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (expanz_codegen_model_ProcessStep*) currentStep {
    return _currentStep;
}


- (void) setCurrentStep:(expanz_codegen_model_ProcessStep*)currentStep {
    _currentStep = currentStep;
    if (_currentStep == [ProcessStep projectLocation]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
        [_currentStepViewContainer setDocumentView:_projectLocationViewController.view];
    }
    else if (_currentStep == [ProcessStep expanzSettings]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
        [_projectLocationViewController setSelectedProjectFilePath:_projectFilePath];
    }
    else if (_currentStep == [ProcessStep activities]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:2] byExtendingSelection:NO];
    }
}

- (IBAction) previousStep {
    NSUInteger currentStepIndex = [[ProcessStep allSteps] indexOfObject:_currentStep];
    if (currentStepIndex != 0) {
        ProcessStep* previousStep = [[ProcessStep allSteps] objectAtIndex:currentStepIndex - 1];
        [self setCurrentStep:previousStep];
    }
}

- (IBAction) nextStep {
    NSUInteger currentStepIndex = [[ProcessStep allSteps] indexOfObject:_currentStep];
    if (currentStepIndex + 1 <= [[ProcessStep allSteps] count]) {
        ProcessStep* nextStep = [[ProcessStep allSteps] objectAtIndex:currentStepIndex + 1];
        [self setCurrentStep:nextStep];
    }
}

- (void) windowDidLoad {
    [super windowDidLoad];
    [_previousStepButton setAction:@selector(previousStep)];
    [_nextStepButton setAction:@selector(nextStep)];
    [_processStepsTableView reloadData];
    if (_projectFilePath.length > 0) {
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


@end