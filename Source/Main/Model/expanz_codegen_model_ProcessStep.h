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


@interface expanz_codegen_model_ProcessStep : NSObject

@property(nonatomic, strong, readonly) NSString* stepName;
@property(nonatomic, strong, readonly) NSString* imageResourceName;

+ (id) fromPlistRepresentation:(NSDictionary*)plistRepresentation;

- (id) initWithStepName:(NSString*)stepName imageResourceName:(NSString*)imageResourceName;

- (NSDictionary*)plistRepresentation;


@end
/* ================================================================================================================== */
@compatibility_alias ProcessStep expanz_codegen_model_ProcessStep;