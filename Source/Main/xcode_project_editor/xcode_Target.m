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
#import "xcode_Project.h"


@implementation xcode_Target

@synthesize name = _name;
@synthesize buildFiles = _buildFiles;

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)name buildFiles:(NSArray*)buildFiles {
    self = [super init]; 
    if (self) {
        _name = [name copy];
        _buildFiles = [NSArray arrayWithArray:buildFiles];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Target: name=%@, files=%@", _name, _buildFiles];
}

@end
