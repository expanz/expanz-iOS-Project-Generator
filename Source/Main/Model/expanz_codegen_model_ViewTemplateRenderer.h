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
@class xcode_ClassDefinition;
@class xcode_XibDefinition;
@class expanz_codegen_model_GeneratedView;

@interface expanz_codegen_model_ViewTemplateRenderer : NSObject {

@private
    GRMustacheTemplate* _headerTemplate;
    GRMustacheTemplate* _implTemplate;
    GRMustacheTemplate* _xibTemplate;
}


- (id) initWithHeaderTemplate:(NSString*)headerTemplate implTemplate:(NSString*)implTemplate
        xibTemplate:(NSString*)xibTemplate;

- (xcode_ClassDefinition*) classDefinitionWith:(expanz_codegen_model_GeneratedView*)view;

- (xcode_XibDefinition*) xibDefinitionWith:(expanz_codegen_model_GeneratedView*)view;


@end
/* ================================================================================================================== */
@compatibility_alias ViewTemplateRenderer expanz_codegen_model_ViewTemplateRenderer;