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
#import "expanz_codegen_ui_EventHandler.h"
#import "ExpanzSiteDetailsClient.h"

@class JSObjectionInjector;
@class expanz_model_ActivityMenu;
@class expanz_codegen_model_ViewTemplateRenderer;


@interface expanz_codegen_ui_ActivitySelectionViewController : NSViewController<ExpanzSiteDetailsClientDelegate,
    NSTableViewDataSource, NSTableViewDelegate> {

@private
    id<expanz_codegen_ui_EventHandler> _delegate;
    id<ExpanzSiteDetailsClient> _siteClient;
    expanz_model_ActivityMenu* _activityList;
    expanz_codegen_model_ViewTemplateRenderer* _detailViewRenderer;
    expanz_codegen_model_ViewTemplateRenderer* _summaryListViewRenderer;
    int _selectedActivityCount;
    int _receivedActivityCount;
}

@property(nonatomic, weak) IBOutlet NSTableView* activityTableView;

- (id) initWithDelegate:(id<expanz_codegen_ui_EventHandler>)delegate;


- (void) populateActivityList;

- (void) generateSelectedActivities;


@end
/* ================================================================================================================== */
@compatibility_alias ActivitySelectionViewController expanz_codegen_ui_ActivitySelectionViewController;