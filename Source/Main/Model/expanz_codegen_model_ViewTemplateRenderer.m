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

#import "expanz_codegen_model_ViewTemplateRenderer.h"
#import "GRMustacheTemplate.h"
#import "xcode_ClassDefinition.h"
#import "xcode_XibDefinition.h"
#import "expanz_codegen_model_GeneratedView.h"

@interface expanz_codegen_model_ViewTemplateRenderer (private)

- (NSDictionary*) wrapClassName:(NSString*)name;

@end


@implementation expanz_codegen_model_ViewTemplateRenderer

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
- (xcode_ClassDefinition*) classDefinitionWith:(expanz_codegen_model_GeneratedView*)view {

    ClassDefinition* classDefinition = [[ClassDefinition alloc] initWithName:[view controllerClassName]];
    [classDefinition setHeader:[_headerTemplate renderObject:view]];
    [classDefinition setSource:[_implTemplate renderObject:view]];
    return classDefinition;
}

- (xcode_XibDefinition*) xibDefinitionWith:(expanz_codegen_model_GeneratedView*)view {
    XibDefinition* xibDefinition = [[XibDefinition alloc] initWithName:[view nibName]];
    [xibDefinition setContent:[_xibTemplate renderObject:view]];
    return xibDefinition;
}

/* ================================================== Private Methods =============================================== */
- (NSDictionary*) wrapClassName:(NSString*)name {
    return [NSDictionary dictionaryWithObject:name forKey:@"controllerClassName"];
}


@end