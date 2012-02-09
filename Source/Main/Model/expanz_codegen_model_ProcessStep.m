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
#import "expanz_codegen_model_ProcessStep.h"


@implementation expanz_codegen_model_ProcessStep

static ProcessStep* globalProjectLocationStep;
static ProcessStep* globalExpanzSettingsStep;
static ProcessStep* globalActivitiesStep;

@synthesize stepName = _stepName;
@synthesize imageResourceName = _imageResourceName;

/* ================================================= Class Methods ================================================== */
+ (expanz_codegen_model_ProcessStep*) projectLocation {
    if (globalProjectLocationStep == nil) {
        globalProjectLocationStep = [[ProcessStep alloc] initWithStepName:@"Project Location" imageResourceName:nil];
    }
    return globalProjectLocationStep;
}

+ (expanz_codegen_model_ProcessStep*) expanzSettings {
    if (globalExpanzSettingsStep == nil) {
        globalExpanzSettingsStep = [[ProcessStep alloc] initWithStepName:@"expanz Settings" imageResourceName:nil];
    }
    return globalExpanzSettingsStep;
}

+ (expanz_codegen_model_ProcessStep*) activities {
    if (globalActivitiesStep == nil) {
        globalActivitiesStep = [[ProcessStep alloc] initWithStepName:@"Activities" imageResourceName:nil];
    }
    return globalActivitiesStep;
}

+ (NSArray*) allSteps {
    return [NSArray arrayWithObjects:[ProcessStep projectLocation], [ProcessStep expanzSettings],
                                     [ProcessStep activities], nil];
}


/* ================================================== Initializers ================================================== */
- (id) initWithStepName:(NSString*)stepName imageResourceName:(NSString*)imageResourceName {
    self = [super init];
    if (self) {
        _stepName = [stepName copy];
        _imageResourceName = [imageResourceName copy];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSDictionary*) plistRepresentation {
    return [NSDictionary dictionaryWithObjectsAndKeys:_stepName, @"stepName", _imageResourceName, @"imageResourceName",
                                                      nil];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ProcessStep: stepName=%@, imageResourceName=%@", _stepName, _imageResourceName];
}


@end
