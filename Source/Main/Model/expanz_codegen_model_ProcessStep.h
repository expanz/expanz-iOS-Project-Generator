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

+ (expanz_codegen_model_ProcessStep*) projectLocationStep;

+ (expanz_codegen_model_ProcessStep*) expanzSettingsStep;

+ (expanz_codegen_model_ProcessStep*) activitiesStep;

+ (NSArray*) allSteps;

- (id) initWithStepName:(NSString*)stepName imageResourceName:(NSString*)imageResourceName;


@end
/* ================================================================================================================== */
@compatibility_alias ProcessStep expanz_codegen_model_ProcessStep;