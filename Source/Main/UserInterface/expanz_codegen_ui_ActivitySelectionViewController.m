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
#import "expanz_codegen_ui_ActivitySelectionViewController.h"
#import "JSObjection.h"
#import "expanz_codegen_model_UserSession.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_ActivitySchema.h"
#import "expanz_codegen_model_ViewTemplateRenderer.h"
#import "expanz_codegen_model_GeneratedView.h"
#import <XcodeEditor/XcodeEditor.h>

@interface expanz_codegen_ui_ActivitySelectionViewController (private)

- (void) assembleDetailViewRenderer;

- (void) assembleSummaryViewRenderer;

- (void) terminate;

@end


@implementation expanz_codegen_ui_ActivitySelectionViewController

@synthesize activityTableView = _activityTableView;

/* ================================================== Initializers ================================================== */


- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate {
    self = [super initWithNibName:@"activities" bundle:[NSBundle mainBundle]];
    if (self) {
        _delegate = delegate;
        [self assembleDetailViewRenderer];
        [self assembleSummaryViewRenderer];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) populateActivityList {
    _activityList = nil;
    [_activityTableView reloadData];
    LogDebug(@"Dispatch request: %@", [UserSession sharedUserSession].selectedSite);
    _siteClient = [[JSObjection globalInjector] getObject:@protocol(ExpanzSiteDetailsClient)];
    [_siteClient listActivitiesForSite:[UserSession sharedUserSession].selectedSite withDelegate:self];
}

- (void) generateSelectedActivities {
    NSIndexSet* indexSet = [_activityTableView selectedRowIndexes];
    _selectedActivityCount = [indexSet count];

    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL* stop) {
        MenuItem* menuItem = [[_activityList activities] objectAtIndex:index];
        NSString* selectedSite = [UserSession sharedUserSession].selectedSite;
        [_siteClient site:selectedSite requestSchemaForActivity:[menuItem activityId] withDelegate:self];
    }];

}



/* ================================================= Protocol Methods =============================================== */
#pragma mark SiteClientDelegate

- (void) requestDidFinishWithActivityMenu:(ActivityMenu*)activityList {
    LogDebug(@"Got response: %@", activityList);
    _activityList = activityList;
    [_activityTableView reloadData];
}

- (void) requestDidFinishWithActivitySchema:(ActivitySchema*)activitySchema {
    @synchronized (self) {

        Project* project = [[UserSession sharedUserSession] project];
        NSString* groupName = [[[UserSession sharedUserSession] projectFilePath] lastPathComponent];
        Group* group = [project groupWithPathRelativeToParent:groupName];

        for (ActivityStyle* style in [activitySchema styles]) {
            GeneratedView* generatedView = [[GeneratedView alloc] initWithStyle:style schema:activitySchema];

            ViewTemplateRenderer* renderer;
            if ([style formLayout] == DetailLayoutStyle) {
                renderer = _detailViewRenderer;
            }
            else if ([style formLayout] == SummaryListLayoutStyle) {
                renderer = _summaryListViewRenderer;
            }

            [group addClass:[renderer classDefinitionWith:generatedView] toTargets:[project targets]];
            [group addXib:[renderer xibDefinitionWith:generatedView] toTargets:[project targets]];
        }

        _receivedActivityCount++;
        if (_receivedActivityCount == _selectedActivityCount) {
            [project save];
            NSAlert* alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:@"Controller and xibs for selected activities were generated successfully."];
            [alert setAlertStyle:NSInformationalAlertStyle];
            [alert beginSheetModalForWindow:self.view.window modalDelegate:self didEndSelector:@selector(terminate)
                    contextInfo:nil];
        }
    }
}


- (void) requestDidFailWithError:(NSError*)error {
    LogDebug(@"Got this error: %@", error);
}

/* ================================================================================================================== */
#pragma mark table view data source & delegate

- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
    return [[_activityList activities] count];

}

- (id) tableView:(NSTableView*)tableView objectValueForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
    MenuItem* activityDefinition = [[_activityList activities] objectAtIndex:row];
    NSString* identifier = [tableColumn identifier];

    NSString* columnValue;
    if ([identifier isEqualToString:@"Id"]) {
        columnValue = [activityDefinition activityId];
    }
    else if ([identifier isEqualToString:@"Title"]) {
        columnValue = [activityDefinition title];
    }
    return columnValue;
}

- (void) tableViewSelectionDidChange:(NSNotification*)notification {
    [_delegate didSelectActivity];
}

/* ================================================== Private Methods =============================================== */
- (void) assembleDetailViewRenderer {
    NSString* headerTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailViewHeader" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    NSString* implTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailViewImpl" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    NSString* xibTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"detailViewXib" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    _detailViewRenderer = [[ViewTemplateRenderer alloc]
            initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];
}

- (void) assembleSummaryViewRenderer {
    NSString* headerTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"summaryListViewHeader" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    NSString* implTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"summaryListViewImpl" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    NSString* xibTemplate = [NSString
            stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"summaryListViewXib" ofType:@"mustache"]
            encoding:NSUTF8StringEncoding error:nil];

    _summaryListViewRenderer = [[ViewTemplateRenderer alloc]
            initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];
}

- (void) terminate {
    [NSApp terminate:nil];
}


@end