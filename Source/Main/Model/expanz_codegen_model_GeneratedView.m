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
#import "expanz_codegen_model_GeneratedView.h"
#import "expanz_model_ActivitySchema.h"
#import "expanz_model_ActivityStyle.h"
#import "NSString+ExpanzUtils.h"


@implementation expanz_codegen_model_GeneratedView

@synthesize style = _style;
@synthesize schema = _schema;

/* ================================================== Initializers ================================================== */
- (id) initWithStyle:(expanz_model_ActivityStyle*)style schema:(expanz_model_ActivitySchema*)schema {
    self = [super init];
    if (self) {
        _style = style;
        _schema = schema;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) controllerClassName {
    return [NSString controllerClassNameForActivityId:[_schema activityId] style:_style];

}

- (NSString*) nibName {
    return [NSString nibNameForActivityId:[_schema activityId] style:_style];
}


@end
