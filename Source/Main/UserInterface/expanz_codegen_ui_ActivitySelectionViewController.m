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
#import "expanz_model_ActivityMenuItem.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_ActivitySchema.h"
#import "expanz_codegen_model_ActivityGenerator.h"
#import "xcode_Project.h"
#import "xcode_Group.h"
#import "xcode_ClassDefinition.h"
#import "xcode_XibDefinition.h"


@implementation expanz_codegen_ui_ActivitySelectionViewController

@synthesize activityTableView = _activityTableView;

/* ================================================== Initializers ================================================== */
- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate {
    self = [super initWithNibName:@"activities" bundle:[NSBundle mainBundle]];
    if (self) {
        _delegate = delegate;
        NSString* headerTemplate = [NSString
                stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"controllerHeader" ofType:@"mustache"]
                encoding:NSUTF8StringEncoding error:nil];

        NSString* implTemplate = [NSString
                stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"controllerImpl" ofType:@"mustache"]
                encoding:NSUTF8StringEncoding error:nil];

        NSString* xibTemplate = [NSString
                stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"uiFile" ofType:@"mustache"]
                encoding:NSUTF8StringEncoding error:nil];

        _generator = [[ActivityGenerator alloc]
                initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) populateActivityList {
    _activityList = nil;
    [_activityTableView reloadData];
    LogDebug(@"Dispatch request: %@", [UserSession sharedUserSession].selectedSite);
    _siteClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SiteDetailsClient)];
    [_siteClient listActivitiesForSite:[UserSession sharedUserSession].selectedSite withDelegate:self];
}

- (void) generateSelectedActivity {
    ActivityMenuItem* menuItem = [[_activityList activities] objectAtIndex:[_activityTableView selectedRow]];
    [_siteClient site:[UserSession sharedUserSession].selectedSite requestSchemaForActivity:[menuItem activityId]
            withDelegate:self];
}



/* ================================================= Protocol Methods =============================================== */
#pragma mark SiteClientDelegate

- (void) requestDidFinishWithActivityMenu:(ActivityMenu*)activityList {
    LogDebug(@"Got response: %@", activityList);
    _activityList = activityList;
    [_activityTableView reloadData];
}

- (void) requestDidFinishWithActivitySchema:(ActivitySchema*)activitySchema {
    LogDebug(@"Here's the schema! :%@", activitySchema);

    Project* project = [[UserSession sharedUserSession] project];
    NSString* groupName = [[[UserSession sharedUserSession] projectFilePath] lastPathComponent];
    Group* group = [project groupWithPathRelativeToParent:groupName];

    for (ActivityStyle* style in [activitySchema styles]) {
        NSString* viewControllerName = [style controllerClassNameForActivityId:activitySchema.activityId];
        ClassDefinition* classDefinition = [[ClassDefinition alloc] initWithName:viewControllerName];
        [classDefinition setHeader:[_generator headerForSchema:activitySchema controllerClassName:viewControllerName]];
        [classDefinition
                setSource:[_generator implementationForSchema:activitySchema controllerClassName:viewControllerName]];
        [group addClass:classDefinition toTargets:[project targets]];

        NSString* xibFileName = [style nibNameForActivityId:activitySchema.activityId];
        XibDefinition* xibDefinition = [[XibDefinition alloc] initWithName:xibFileName
                content:[_generator xibForSchema:activitySchema controllerClassName:viewControllerName]];
        [group addXib:xibDefinition toTargets:[project targets]];
    }
    [project save];

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
    ActivityMenuItem* activityDefinition = [[_activityList activities] objectAtIndex:row];
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


@end