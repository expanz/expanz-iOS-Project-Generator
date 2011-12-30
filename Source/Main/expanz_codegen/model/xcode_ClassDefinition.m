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

#import "xcode_ClassDefinition.h"
#import "expanz_codegen_utils_FileKeyBuilder.h"

@implementation xcode_ClassDefinition


@synthesize className = _className;
@synthesize language = _language;
@synthesize header = _header;
@synthesize source = _source;

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)fileName {
    self = [super init];
    if (self) {
        _className = [fileName copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */

- (void) setLanguage:(ClassDefinitionLanguage)language {
    if (!(language == ObjectiveC || language == ObjectiveCPlusPlus)) {
        [NSException raise:NSInvalidArgumentException format:@"Language must be one of ObjectiveC, ObjectiveCPlusPlus"];
    }
    _language = language;
}

- (BOOL) isObjectiveC {
    return _language == ObjectiveC;

}

- (BOOL) isObjectiveCPlusPlus {
    return _language == ObjectiveCPlusPlus;
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    LogDebug(@"Bye bye now");
}
@end
