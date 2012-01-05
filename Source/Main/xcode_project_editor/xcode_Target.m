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

#import "xcode_Target.h"
#import "xcode_ProjectFile.h"
#import "xcode_Project.h"

@implementation xcode_Target

@synthesize project = _project;
@synthesize name = _name;
@synthesize members = _members;

/* ================================================== Initializers ================================================== */
- (id) initWithProject:(xcode_Project*)project name:(NSString*)name members:(NSArray*)members {
    self = [super init]; 
    if (self) {
        _project = project;
        _name = [name copy];
        _members = [NSArray arrayWithArray:members];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) addMember:(xcode_ProjectFile*)member {
    [member becomeBuildFile];
    //NSDictionary* target = [[_project objects] objectForKey:<#(id)aKey#>];

}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Target: name=%@, files=%@", _name, _members];
}

@end
