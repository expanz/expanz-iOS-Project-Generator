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
#import "expanz_service_SiteClientDelegate.h"
#import "expanz_model_ActivityDefinitionList.h"

@class JSObjectionInjector;


@interface expanz_codegen_ui_ActivitySelectionViewController : NSViewController<expanz_service_SiteClientDelegate,
    NSTableViewDataSource, NSTableViewDelegate> {

@private
    expanz_model_ActivityDefinitionList* _activityList;
}

@property(nonatomic, weak) IBOutlet NSTableView* activityTableView;

- (void) populateActivityList;


@end
/* ================================================================================================================== */
@compatibility_alias ActivitySelectionViewController expanz_codegen_ui_ActivitySelectionViewController;