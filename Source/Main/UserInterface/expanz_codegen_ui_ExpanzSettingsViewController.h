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
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "expanz_service_SiteClient.h"

@class JSObjectionInjector;
@class expanz_model_SiteList;

@interface expanz_codegen_ui_ExpanzSettingsViewController : NSViewController<expanz_service_SiteClientDelegate,
    NSTableViewDelegate, NSTableViewDataSource> {

@private
    JSObjectionInjector* _injector;
    expanz_model_SiteList* _siteList;
}

@property(nonatomic, weak) IBOutlet NSComboBox* expanzBackendCombo;
@property(nonatomic, weak) IBOutlet NSTableView* siteListTableView;
@property(nonatomic, strong) NSString* projectFilePath;
@property(nonatomic, strong) id<expanz_service_SiteClient> siteClient;
@property(nonatomic) BOOL configFilesNeedLoading;

- (NSString*) supportingFilesPath;

- (void) populateExpanzBackendCombo;

- (void) populateSiteList;

@end
/* ================================================================================================================== */
@compatibility_alias ExpanzSettingsViewController expanz_codegen_ui_ExpanzSettingsViewController;

