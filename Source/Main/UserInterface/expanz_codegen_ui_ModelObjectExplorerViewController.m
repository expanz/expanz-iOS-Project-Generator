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
- (id) initWithProjectFilePath:(NSString*)projectFilePath processSteps:(NSArray*)processSteps {
    self = [super initWithWindowNibName:@"ModelObjectExplorer"];
    if (self) {
        _projectFilePath = [projectFilePath copy];
        _processSteps = processSteps;
    }    
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) windowDidLoad {
    [super windowDidLoad];    
    [_processStepsTableView reloadData];
}


- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
    return [_processSteps count];
}

- (NSView*) tableView:(NSTableView*)tableView viewForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {    
    ProcessStep* processStep = [_processSteps objectAtIndex:row];
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