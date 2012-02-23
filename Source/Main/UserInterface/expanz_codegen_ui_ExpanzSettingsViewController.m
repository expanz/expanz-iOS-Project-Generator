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
#import "expanz_CoreModule.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_AppSite.h"

@implementation expanz_codegen_ui_ExpanzSettingsViewController

@synthesize projectFilePath = _projectFilePath;
@synthesize expanzBackendCombo = _expanzBackendCombo;
@synthesize siteClient = _siteClient;
@synthesize siteListTableView = _siteListTableView;
@synthesize configFilesNeedLoading = _configFilesNeedLoading;


/* ================================================ Interface Methods =============================================== */
- (void) awakeFromNib {
    [super awakeFromNib];
    _configFilesNeedLoading = YES;
    [_expanzBackendCombo setTarget:self];
    [_expanzBackendCombo setAction:@selector(populateSiteList)];
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
    NSString* configFilePath =
        [[self supportingFilesPath] stringByAppendingPathComponent:[_expanzBackendCombo objectValueOfSelectedItem]];

    SdkConfiguration* configuration = [[SdkConfiguration alloc]
        initWithXmlString:[NSString stringWithContentsOfFile:configFilePath encoding:NSUTF8StringEncoding error:nil]];
    [SdkConfiguration clearGlobalConfiguration];
    [SdkConfiguration setGlobalConfiguration:configuration];
    LogDebug(@"Here's the configuration: %@", configuration);
    _injector = [JSObjection createInjector:[[CoreModule alloc] init]];

    _siteClient = [_injector getObject:@protocol(expanz_service_SiteClient)];
    [_siteClient listAvailableSitesWith:self];
    LogDebug(@"Ok - now populate the site list with value: %@", [_expanzBackendCombo objectValueOfSelectedItem]);
}


- (NSString*) supportingFilesPath {
    return [[_projectFilePath stringByAppendingPathComponent:[_projectFilePath lastPathComponent]]
        stringByAppendingPathComponent:@"Supporting Files"];
}

/* ================================================= Protocol Methods =============================================== */
- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    LogDebug(@"Got site list: %@", siteList);
    _siteList = siteList;
    [_siteListTableView reloadData];
}


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


@end