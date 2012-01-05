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
#import "XcodeProjectNodeType.h"
#import "xcode_KeyBuilder.h"

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

    __block BOOL isBuildFile = NO;
    if (_type == SourceCodeObjC) {
        [[_project objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {
            if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXBuildFile) {
                if ([[obj valueForKey:@"fileRef"] isEqualToString:_key]) {
                    isBuildFile = YES;
                }
            }
        }];
    }
    return isBuildFile;
}

- (void) becomeBuildFile {
    if (![self isBuildFile]) {
        NSMutableDictionary* buildFile = [[NSMutableDictionary alloc] init];
        [buildFile setObject:[NSString stringFromProjectNodeType:PBXBuildFile] forKey:@"isa"];
        [buildFile setObject:_key forKey:@"fileRef"];
        NSString* buildFileKey = [[KeyBuilder forItemNamed:[_path stringByAppendingString:@".buildFile"]] build];
        [[_project objects] setObject:buildFile forKey:buildFileKey];
    }
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Project file: key=%@, path=%@", _key, _path];
}


@end