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
#import "expanz_model_ActivitySchema.h"

@class GRMustacheTemplate;

@interface expanz_codegen_model_ActivityGenerator : NSObject {

@private
    GRMustacheTemplate* _headerTemplate;
    GRMustacheTemplate* _implTemplate;
    GRMustacheTemplate* _xibTemplate;
}


- (id) initWithHeaderTemplate:(NSString*)headerTemplate implTemplate:(NSString*)implTemplate
        xibTemplate:(NSString*)xibTemplate;

- (NSString*) headerForSchema:(expanz_model_ActivitySchema*)schema controllerClassName:(NSString*)className;

- (NSString*) implementationForSchema:(expanz_model_ActivitySchema*)schema controllerClassName:(NSString*)className;;

- (NSString*) xibForSchema:(expanz_model_ActivitySchema*)schema controllerClassName:(NSString*)className;;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityGenerator expanz_codegen_model_ActivityGenerator;