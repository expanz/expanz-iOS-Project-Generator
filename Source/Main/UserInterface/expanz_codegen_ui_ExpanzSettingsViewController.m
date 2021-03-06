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

#import "expanz_codegen_ui_ExpanzSettingsViewController.h"
#import "expanz_SdkConfiguration.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_AppSite.h"
#import "expanz_codegen_model_UserSession.h"
#import "expanz_codegen_ui_EventHandler.h"

/* ================================================================================================================== */
@interface expanz_codegen_ui_ExpanzSettingsViewController (Private)

- (NSString*) supportingFilesPath;

@end

/* ================================================================================================================== */
@implementation expanz_codegen_ui_ExpanzSettingsViewController

@synthesize expanzBackendCombo = _expanzBackendCombo;
@synthesize siteListTableView = _siteListTableView;
@synthesize configFilesNeedLoading = _configFilesNeedLoading;


/* ================================================== Initializers ================================================== */
- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate {
    self = [super initWithNibName:@"expanzSettings" bundle:[NSBundle mainBundle]];
    if (self) {
        _delegate = delegate;
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) awakeFromNib {
    [super awakeFromNib];
    _configFilesNeedLoading = YES;
    [_expanzBackendCombo setTarget:self];
    [_expanzBackendCombo setAction:@selector(populateSiteList)];
    [_siteListTableView setAction:@selector(selectedSiteDidChange)];
}

- (void) populateExpanzBackendCombo {
    [_expanzBackendCombo removeAllItems];
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSArray* supportingFiles = [fileManager contentsOfDirectoryAtPath:[self supportingFilesPath] error:nil];
    for (NSString* supportingFile in supportingFiles) {
        if ([supportingFile hasSuffix:@"_environment.xml"]) {
            [_expanzBackendCombo addItemWithObjectValue:supportingFile];
        }
    }
    [_expanzBackendCombo selectItemAtIndex:0];
    _configFilesNeedLoading = NO;
    [self performSelectorInBackground:@selector(populateSiteList) withObject:nil];
}

- (void) populateSiteList {
    _siteList = nil;
    [_siteListTableView reloadData];
    NSString* configFilePath =
            [[self supportingFilesPath] stringByAppendingPathComponent:[_expanzBackendCombo objectValueOfSelectedItem]];

    LogDebug(@"Config file path: %@", configFilePath);

    SdkConfiguration* configuration = [[SdkConfiguration alloc]
            initWithXmlString:[NSString stringWithContentsOfFile:configFilePath encoding:NSUTF8StringEncoding
                                      error:nil]];
    [SdkConfiguration clearGlobalConfiguration];
    [SdkConfiguration setGlobalConfiguration:configuration];

    id<ExpanzSiteDetailsClient>
            siteDetailsClient = [[JSObjection globalInjector] getObject:@protocol(ExpanzSiteDetailsClient)];
    [siteDetailsClient listAvailableSitesWithDelegate:self];
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark SiteClientDelegate
- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    LogDebug(@"Got site list: %@", siteList);
    _siteList = siteList;
    [_siteListTableView reloadData];
}

- (void) requestDidFailWithError:(NSError*)error {
    LogDebug(@"Error: %@", error);
    NSAlert* alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"An error occured. See logs for further details"];
    [alert setAlertStyle:NSCriticalAlertStyle];
    [alert beginSheetModalForWindow:self.view.window modalDelegate:self didEndSelector:nil contextInfo:nil];
}


/* ================================================================================================================== */
#pragma mark Table view delegate & datasource
- (NSInteger) numberOfRowsInTableView:(NSTableView*)tableView {
    return [[_siteList sites] count];

}

- (id) tableView:(NSTableView*)tableView objectValueForTableColumn:(NSTableColumn*)tableColumn row:(NSInteger)row {
    AppSite* site = [[_siteList sites] objectAtIndex:row];
    NSString* identifier = [tableColumn identifier];

    NSString* columnValue;
    if ([identifier isEqualToString:@"Id"]) {
        columnValue = [site appSiteId];
    }
    else if ([identifier isEqualToString:@"Description"]) {
        columnValue = [site name];
    }
    else if ([identifier isEqualToString:@"Preferred"]) {
        if (site == [_siteList preferredSite]) {
            columnValue = @"Y";
        }
    }
    return columnValue;

}

- (void) tableViewSelectionDidChange:(NSNotification*)notification {
    AppSite* site = [[_siteList sites] objectAtIndex:[_siteListTableView selectedRow]];
    [[UserSession sharedUserSession] setSelectedSite:site.appSiteId];
    LogDebug(@"Set selected site to %@", site.appSiteId);
    [_delegate didSelectSite];
}


/* ================================================== Private Methods =============================================== */
- (NSString*) supportingFilesPath {
    NSString* projectFilePath = [[UserSession sharedUserSession] projectFilePath];
    return [[projectFilePath stringByAppendingPathComponent:[projectFilePath lastPathComponent]]
            stringByAppendingPathComponent:@"Supporting Files"];
}

@end