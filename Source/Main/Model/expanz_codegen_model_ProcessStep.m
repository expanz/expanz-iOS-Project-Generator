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


@synthesize stepName = _stepName;
@synthesize imageResourceName = _imageResourceName;

/* ================================================= Class Methods ================================================== */
+ (id) fromPlistRepresentation:(NSDictionary*)plistRepresentation {
    return [[ProcessStep alloc] initWithStepName:[plistRepresentation valueForKey:@"stepName"]
                               imageResourceName:[plistRepresentation valueForKey:@"imageResourceName"]];
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
    return [NSDictionary dictionaryWithObjectsAndKeys:
        _stepName, @"stepName",
        _imageResourceName, @"imageResourceName",
        nil];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ProcessStep: stepName=%@, imageResourceName=%@", _stepName, _imageResourceName];
}


@end
