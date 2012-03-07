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
    return [_style controllerClassNameForActivityId:[_schema activityId]];

}

- (NSString*) nibName {
    return [_style nibNameForActivityId:[_schema activityId]];
}


@end
