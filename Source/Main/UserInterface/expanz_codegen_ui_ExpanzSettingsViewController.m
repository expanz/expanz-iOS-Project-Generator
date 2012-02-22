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

@implementation expanz_codegen_ui_ExpanzSettingsViewController

@synthesize projectFilePath = _projectFilePath;
@synthesize expanzBackendCombo = _expanzBackendCombo;
@synthesize siteClient = _siteClient;


/* ================================================ Interface Methods =============================================== */
- (void) awakeFromNib {
    [super awakeFromNib];
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
    [self populateSiteList];
}

- (void) populateSiteList {
    NSString* configFilePath =
        [[self supportingFilesPath] stringByAppendingPathComponent:[_expanzBackendCombo objectValueOfSelectedItem]];

    SdkConfiguration* configuration = [[SdkConfiguration alloc]
        initWithXmlString:[NSString stringWithContentsOfFile:configFilePath encoding:NSUTF8StringEncoding error:nil]];
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

}

- (void) requestDidFailWithError:(NSError*)error {
    LogDebug(@"Oh fuck! An error!");
}


@end