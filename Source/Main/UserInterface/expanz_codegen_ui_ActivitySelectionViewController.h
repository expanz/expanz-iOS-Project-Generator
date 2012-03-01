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
#import "expanz_service_SiteDetailsClientDelegate.h"

@class JSObjectionInjector;
@class expanz_model_ActivityMenu;


@interface expanz_codegen_ui_ActivitySelectionViewController : NSViewController<expanz_service_SiteDetailsClientDelegate,
    NSTableViewDataSource, NSTableViewDelegate> {

@private
    expanz_model_ActivityMenu* _activityList;
}

@property(nonatomic, weak) IBOutlet NSTableView* activityTableView;

- (void) populateActivityList;


@end
/* ================================================================================================================== */
@compatibility_alias ActivitySelectionViewController expanz_codegen_ui_ActivitySelectionViewController;