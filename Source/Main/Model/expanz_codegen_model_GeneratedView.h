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

@class expanz_model_ActivitySchema;
@class expanz_model_ActivityStyle;


@interface expanz_codegen_model_GeneratedView : NSObject

@property (nonatomic, strong, readonly) expanz_model_ActivityStyle* style;
@property (nonatomic, strong, readonly) expanz_model_ActivitySchema* schema;

- (id) initWithStyle:(expanz_model_ActivityStyle*)style schema:(expanz_model_ActivitySchema*)schema;

- (NSString*) controllerClassName;

- (NSString*) nibName;

@end
/* ================================================================================================================== */
@compatibility_alias GeneratedView expanz_codegen_model_GeneratedView;