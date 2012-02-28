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
#import "expanz_codegen_model_UserSession.h"


@implementation expanz_codegen_model_UserSession

@synthesize projectFilePath = _projectFilePath;
@synthesize selectedSite = _selectedSite;

static expanz_codegen_model_UserSession* sharedUserSession;

/* ================================================= Class Methods ================================================== */
+ (expanz_codegen_model_UserSession*) sharedUserSession {
    if (sharedUserSession == nil) {
        sharedUserSession = [[UserSession alloc] init];
    }
    return sharedUserSession;
}

/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _selectedActivities = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) selectedActivities {
    return [_selectedActivities sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

}

- (void) addSelectedActivity:(NSString*)selectedActivityId {
    [_selectedActivities addObject:selectedActivityId];
}


@end