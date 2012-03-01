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
#import "expanz_service_SiteDetailsClient.h"

@class JSObjectionInjector;
@class expanz_model_SiteList;
@protocol expanz_codegen_ui_EventHandler;

@interface expanz_codegen_ui_ExpanzSettingsViewController : NSViewController<expanz_service_SiteDetailsClientDelegate,
    NSTableViewDelegate, NSTableViewDataSource> {

@private
    expanz_model_SiteList* _siteList;
    id<expanz_codegen_ui_EventHandler> _delegate;
}

@property(nonatomic, weak) IBOutlet NSComboBox* expanzBackendCombo;
@property(nonatomic, weak) IBOutlet NSTableView* siteListTableView;
@property(nonatomic) BOOL configFilesNeedLoading;

- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate;


- (void) populateExpanzBackendCombo;

- (void) populateSiteList;

@end
/* ================================================================================================================== */
@compatibility_alias ExpanzSettingsViewController expanz_codegen_ui_ExpanzSettingsViewController;

