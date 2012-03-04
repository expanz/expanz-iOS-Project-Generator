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
#import "expanz_service_SiteDetailsClient.h"
#import "JSObjection.h"
#import "expanz_codegen_model_UserSession.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_ActivityMenuItem.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_ActivitySchema.h"
#import "expanz_codegen_model_ActivityGenerator.h"
#import "xcode_Project.h"
#import "xcode_Group.h"
#import "xcode_ClassDefinition.h"
#import "xcode_Target.h"
#import "xcode_File.h"


@implementation expanz_codegen_ui_ActivitySelectionViewController

@synthesize activityTableView = _activityTableView;

/* ================================================== Initializers ================================================== */
- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate {
    self = [super initWithNibName:@"activities" bundle:[NSBundle mainBundle]];
    if (self) {
        _delegate = delegate;
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
    [_siteClient site:[UserSession sharedUserSession].selectedSite retriveSchemaForActivity:[menuItem activityId]
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

    NSString* headerFilePath = [[NSBundle mainBundle] pathForResource:@"controllerHeader" ofType:@"mustache"];
    NSString* header = [NSString stringWithContentsOfFile:headerFilePath encoding:NSUTF8StringEncoding error:nil];

    NSString* implFilePath = [[NSBundle mainBundle] pathForResource:@"controllerImpl" ofType:@"mustache"];
    NSString* impl = [NSString stringWithContentsOfFile:implFilePath encoding:NSUTF8StringEncoding error:nil];

    ActivityGenerator* generator = [[ActivityGenerator alloc]
        initWithSchema:activitySchema headerTemplate:header implTemplate:impl xibTemplate:nil];

    LogDebug(@"Header: %@", [generator headerText]);
    LogDebug(@"Impl: %@", [generator implText]);

    Project* project = [[UserSession sharedUserSession] project];
    NSString* groupName = [[[UserSession sharedUserSession] projectFilePath] lastPathComponent];
    Group* group = [project groupWithPathRelativeToParent:groupName];
    ClassDefinition* classDefinition = [[ClassDefinition alloc] initWithName:[activitySchema viewControllerName]];
    [classDefinition setHeader:[generator headerText]];
    [classDefinition setSource:[generator implText]];
    [group addClass:classDefinition];
    [project save];

    File* file = [project fileWithName:[[activitySchema viewControllerName] stringByAppendingString:@".m"]];
    for (Target* target in [project targets]) {
        [target addMember:file];
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