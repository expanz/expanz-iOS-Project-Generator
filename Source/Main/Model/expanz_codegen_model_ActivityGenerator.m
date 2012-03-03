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
#import "expanz_codegen_model_ActivityGenerator.h"


@implementation expanz_codegen_model_ActivityGenerator

@synthesize schema = _schema;

/* ================================================== Initializers ================================================== */
- (id) initWithSchema:(ActivitySchema*)schema {
    self = [super init];
    if (self) {
        _schema = schema;
    }
    return self;
}


@end