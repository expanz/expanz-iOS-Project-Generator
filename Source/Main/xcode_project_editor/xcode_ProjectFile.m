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

#import "xcode_ProjectFile.h"
#import "xcode_Project.h"


@implementation xcode_ProjectFile

@synthesize project = _project;
@synthesize key = _key;
@synthesize type = _type;
@synthesize path = _path;


/* ================================================== Initializers ================================================== */
- (id) initWithProject:(xcode_Project*)project key:(NSString*)key type:(XcodeProjectFileType)type path:(NSString*)path {
    self = [super init];
    if (self) {
        _project = project;
        _key = [key copy];
        _type = type;
        _path = [path copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (BOOL) isBuildFile {
    return NO;
    //To change the template use AppCode | Preferences | File Templates.

}

- (void) setAsBuildFile {
    //To change the template use AppCode | Preferences | File Templates.

}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Project file: key=%@, path=%@", _key, _path];
}




@end