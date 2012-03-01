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
#import "expanz_codegen_ui_EventHandler.h"


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
    id<expanz_service_SiteDetailsClient>
            siteClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SiteDetailsClient)];
    [siteClient listActivitiesForSite:[UserSession sharedUserSession].selectedSite withDelegate:self];
}


/* ================================================= Protocol Methods =============================================== */
#pragma mark SiteClientDelegate
- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    //To change the template use AppCode | Preferences | File Templates.

}

- (void) requestDidFinishWithActivityMenu:(expanz_model_ActivityMenu*)activityList {
    LogDebug(@"Got response: %@", activityList);
    _activityList = activityList;
    [_activityTableView reloadData];
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