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


@implementation expanz_codegen_model_ActivityGenerator


/* ================================================== Initializers ================================================== */
- (id) initWithHeaderTemplate:(NSString*)headerTemplate implTemplate:(NSString*)implTemplate
        xibTemplate:(NSString*)xibTemplate {

    self = [super init];
    if (self) {
        NSError* error;
        _headerTemplate = [GRMustacheTemplate templateFromString:headerTemplate error:&error];
        _implTemplate = [GRMustacheTemplate templateFromString:implTemplate error:&error];
        _xibTemplate = [GRMustacheTemplate templateFromString:xibTemplate error:&error];
        if (error) {
            [NSException raise:NSInternalInconsistencyException format:[[error userInfo] description]];
        }
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSString*) headerForSchema:(expanz_model_ActivitySchema*)schema {
    return [_headerTemplate renderObjects:schema];
}

- (NSString*) implementationForSchema:(expanz_model_ActivitySchema*)schema {
    return [_implTemplate renderObject:schema];
}

- (NSString*) xibForSchema:(expanz_model_ActivitySchema*)schema {
    return [_xibTemplate renderObject:schema];
}


@end