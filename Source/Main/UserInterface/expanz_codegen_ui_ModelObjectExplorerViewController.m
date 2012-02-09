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

#import "expanz_codegen_ui_ModelObjectExplorerViewController.h"
#import "expanz_codegen_model_ProcessStep.h"


@implementation expanz_codegen_ui_ModelObjectExplorerViewController

@synthesize processStepsTableView = _processStepsTableView;
@synthesize projectFilePath = _projectFilePath;

/* ================================================== Initializers ================================================== */
- (id) initWithProjectFilePath:(NSString*)projectFilePath {
    self = [super initWithWindowNibName:@"ModelObjectExplorer"];
    if (self) {
        _projectFilePath = [projectFilePath copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) setStep:(ProcessStep*)processStep {
    if (processStep == [ProcessStep projectLocation]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:NO];
    }
    else if (processStep == [ProcessStep expanzSettings]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:1] byExtendingSelection:NO];
    }
    else if (processStep == [ProcessStep activities]) {
        [_processStepsTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:2] byExtendingSelection:NO];
    }
}


- (void) windowDidLoad {
    [super windowDidLoad];
    [_processStepsTableView reloadData];
    if (_projectFilePath.length > 0) {
        [self setStep:[ProcessStep expanzSettings]];
    }
    else {
        [self setStep:[ProcessStep projectLocation]];
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