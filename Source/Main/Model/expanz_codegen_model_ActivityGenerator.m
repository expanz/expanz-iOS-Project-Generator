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
#import "GRMustacheTemplate.h"
#import "expanz_model_FieldSchema.h"


@implementation expanz_codegen_model_ActivityGenerator

@synthesize schema = _schema;
@synthesize headerTemplate = _headerTemplate;
@synthesize implTemplate = _implTemplate;
@synthesize xibTemplate = _xibTemplate;



/* ================================================== Initializers ================================================== */
- (id) initWithSchema:(ActivitySchema*)schema headerTemplate:(NSString*)headerTemplate
        implTemplate:(NSString*)implTemplate xibTemplate:(NSString*)xibTemplate {

    self = [super init];
    if (self) {
        _schema = schema;
        _headerTemplate = headerTemplate;
        _implTemplate = implTemplate;
        _xibTemplate = xibTemplate;
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSString*) headerText {
    NSError* error;
    GRMustacheTemplate* template = [GRMustacheTemplate templateFromString:_headerTemplate error:&error];
    NSString* header = [template renderObjects:_schema];

    LogDebug(@"Errors: %@", error);
    return header;
}


@end