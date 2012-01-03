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

#import "xcode_Project.h"
#import "XcodeProjectNodeType.h"
#import "XcodeFileReferenceType.h"
#import "xcode_Group.h"
#import "xcode_FileWriteQueue.h"
#import "xcode_Target.h"


@interface xcode_Project (private)

- (NSArray*) fileReferencesOfType:(XcodeFileReferenceType)type;

@end


@implementation xcode_Project


@synthesize pendingFiles = _pendingFiles;

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    if (self) {
        _filePath = [filePath copy];
        _project = [[NSMutableDictionary alloc]
            initWithContentsOfFile:[_filePath stringByAppendingPathComponent:@"project.pbxproj"]];
        if (!_project) {
            [NSException raise:NSInvalidArgumentException format:@"Project file not found at file path %@", _filePath];
        }
        _pendingFiles = [[FileWriteQueue alloc] initWithBaseDirectory:[_filePath stringByDeletingLastPathComponent]];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSMutableDictionary*) objects {
    return [_project objectForKey:@"objects"];
}

- (NSArray*) headerFiles {
    return [self fileReferencesOfType:SourceCodeHeader];
}

- (NSArray*) implementationFiles {
    return [self fileReferencesOfType:SourceCodeObjC];
}

- (NSArray*) groups {

    NSMutableArray* results = [[NSMutableArray alloc] init];
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {

        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXGroup) {
            NSString* name = [obj valueForKey:@"name"];
            NSString* path = [obj valueForKey:@"path"];
            NSArray* children = [obj valueForKey:@"children"];

            Group* group = [[Group alloc] initWithKey:key name:name path:path children:children];
            [results addObject:group];
        }
    }];

    return results;
}

- (NSArray*) targets {

    NSMutableArray* results = [[NSMutableArray alloc] init];
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {
        
        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXNativeTarget) {
            Target* target = [[Target alloc] initWithName:[obj valueForKey:@"name"]];
            [results addObject:target];
        }
    }];
    return results;
}


- (Group*) groupWithName:(NSString*)name {
    for (Group* group in [self groups]) {
        if ([group.name isEqualToString:name]) {
            return group;
        }
    }
    return nil;
}


- (void) save {
    [_pendingFiles writePendingFilesToDisk];
    [_project writeToFile:[_filePath stringByAppendingPathComponent:@"project.pbxproj"] atomically:YES];
}

/* ================================================== Private Methods =============================================== */
- (NSArray*) fileReferencesOfType:(XcodeFileReferenceType)fileReferenceType {
    NSMutableArray* results = [[NSMutableArray alloc] init];

    for (NSDictionary* obj in [[self objects] allValues]) {

        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXFileReference &&
            [[obj valueForKey:@"lastKnownFileType"] asXCodeFileReferenceType] == fileReferenceType) {
            [results addObject:[obj valueForKey:@"path"]];
        }
    }
    return [results sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];;
}


@end