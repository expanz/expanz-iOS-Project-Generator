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

#import "xcode_BuildFile.h"
#import "xcode_ProjectFile.h"

@implementation xcode_BuildFile

@synthesize project = _project;
@synthesize key = _key;

- (id) initWithProject:(xcode_Project*)project key:(NSString*)key projectFileKey:(NSString*)projectFileKey {
    self = [super init];
    if (self) {
        _project = project;
        _key = [key copy];
        _projectFileKey = [projectFileKey copy];
    }
    return self;
}

- (xcode_ProjectFile*) file {
    return [_project projectFileWithKey:_projectFileKey];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Build file: %@", [[self file] path]];
}


@end