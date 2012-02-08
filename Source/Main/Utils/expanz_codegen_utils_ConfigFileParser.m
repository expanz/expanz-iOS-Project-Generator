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
#import "expanz_codegen_utils_ConfigFileParser.h"
#import "expanz_codegen_model_ProcessStep.h"

@implementation expanz_codegen_utils_ConfigFileParser

@synthesize configs = _configs;

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    self = [super init];
    if (self) {
        _configs = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSArray*) processSteps {
    NSMutableArray* processSteps = [[NSMutableArray alloc] init];
    for (NSDictionary* dictionary in [[self configs] objectForKey:@"processSteps"]) {
        [processSteps addObject:[ProcessStep fromPlistRepresentation:dictionary]];
    }
    return [NSArray arrayWithArray:processSteps];
}


@end