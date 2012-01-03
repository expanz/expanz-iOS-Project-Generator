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
#import "xcode_KeyBuilder.h"
#import "xcode_ClassDefinition.h"
#import "xcode_FileWriteCache.h"


@interface xcode_Project (private)

- (NSArray*) fileReferencesOfType:(XcodeFileReferenceType)type;

- (NSMutableDictionary*) objects;

- (NSDictionary*) makeFileReference:(NSString*)name type:(XcodeFileReferenceType)type;

@end


@implementation xcode_Project

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    if (self) {
        _filePath = [filePath copy];
        _project = [[NSMutableDictionary alloc]
            initWithContentsOfFile:[_filePath stringByAppendingPathComponent:@"project.pbxproj"]];
        if (!_project) {
            [NSException raise:NSInvalidArgumentException format:@"Project file not found at file path %@", _filePath];
        }
        _fileCache = [[FileWriteCache alloc] initWithBaseDirectory:[_filePath stringByDeletingLastPathComponent]];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) headerFiles {
    return [self fileReferencesOfType:SourceCodeHeader];
}

- (NSArray*) implementationFiles {
    return [self fileReferencesOfType:SourceCodeObjC];
}

- (NSArray*) groups {

    NSMutableArray* results = [[NSMutableArray alloc] init];
    for (NSString* key in [[self objects] allKeys]) {

        NSDictionary* obj = [[self objects] valueForKey:key];
        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXGroup) {

            NSString* name = [obj valueForKey:@"name"];
            NSString* path = [obj valueForKey:@"path"];
            NSArray* children = [obj valueForKey:@"children"];

            Group* group = [[Group alloc] initWithKey:key name:name path:path children:children];
            [results addObject:group];
        }
    }
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

- (void) addClass:(xcode_ClassDefinition*)classDefinition toGroup:(xcode_Group*)group {
    NSDictionary* header = [self makeFileReference:[classDefinition headerFileName] type:SourceCodeHeader];
    NSString* headerKey = [[KeyBuilder forFileName:[classDefinition headerFileName]] build];
    [[self objects] setObject:header forKey:headerKey];

    NSDictionary* source = [self makeFileReference:[classDefinition sourceFileName] type:SourceCodeObjC];
    NSString* sourceKey = [[KeyBuilder forFileName:[classDefinition sourceFileName]] build];
    [[self objects] setObject:source forKey:sourceKey];

    [group addChildWithKey:headerKey];
    [group addChildWithKey:sourceKey];

    NSMutableDictionary* groupData = [[NSMutableDictionary alloc] init];
    [groupData setObject:@"PBXGroup" forKey:@"isa"];
    [groupData setObject:@"<group>" forKey:@"sourceTree"];
    [groupData setObject:[group name] forKey:@"name"];
    [groupData setObject:[group path] forKey:@"path"];
    [groupData setObject:[group children] forKey:@"children"];
    [[self objects] setObject:groupData forKey:[group key]];
    
    [_fileCache spool:[classDefinition headerFileName] inDirectory:[group path] contents:[classDefinition header]];
    [_fileCache spool:[classDefinition sourceFileName] inDirectory:[group path] contents:[classDefinition source]];
}


- (void) save {
    [_fileCache writePendingFilesToDisk];
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

- (NSMutableDictionary*) objects {
    return [_project objectForKey:@"objects"];
}

- (NSDictionary*) makeFileReference:(NSString*)name type:(XcodeFileReferenceType)type {
    NSMutableDictionary* reference = [[NSMutableDictionary alloc] init];
    [reference setObject:@"PBXFileReference" forKey:@"isa"];
    [reference setObject:@"4" forKey:@"FileEncoding"];
    [reference setObject:[NSString stringFromXcodeFileReferenceType:type] forKey:@"lastKnownFileType"];
    [reference setObject:name forKey:@"path"];
    [reference setObject:@"<group>" forKey:@"sourceTree"];
    return reference;
}


@end