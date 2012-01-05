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
#import "XcodeProjectFileType.h"
#import "xcode_Group.h"
#import "xcode_FileWriteQueue.h"
#import "xcode_Target.h"
#import "xcode_ProjectFile.h"


@interface xcode_Project (private)

- (NSArray*) projectFilesOfType:(XcodeProjectFileType)fileReferenceType;

- (ProjectFile*) buildFileWithKey:(NSString*)key;

@end


@implementation xcode_Project


@synthesize fileWriteQueue = _fileWriteQueue;

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    if (self) {
        _filePath = [filePath copy];
        _project = [[NSMutableDictionary alloc]
            initWithContentsOfFile:[_filePath stringByAppendingPathComponent:@"project.pbxproj"]];
        if (!_project) {
            [NSException raise:NSInvalidArgumentException format:@"Project file not found at file path %@", _filePath];
        }
        _fileWriteQueue = [[FileWriteQueue alloc] initWithBaseDirectory:[_filePath stringByDeletingLastPathComponent]];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSMutableDictionary*) objects {
    return [_project objectForKey:@"objects"];
}

- (NSArray*) projectFiles {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {
        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXFileReference) {
            XcodeProjectFileType fileType = [[obj valueForKey:@"lastKnownFileType"] asProjectFileType];
            NSString* path = [obj valueForKey:@"path"];
            [results addObject:[[ProjectFile alloc] initWithProject:self key:key type:fileType path:path]];
        }
    }];
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"path" ascending:YES];
    return [results sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (xcode_ProjectFile*) projectFileWithKey:(NSString*)key {
    for (ProjectFile* projectFile in [self projectFiles]) {
        if ([[projectFile key] isEqualToString:key]) {
            return projectFile;
        }
    }
    return nil;
}


- (NSArray*) headerFiles {
    return [self projectFilesOfType:SourceCodeHeader];
}

- (NSArray*) implementationFiles {
    return [self projectFilesOfType:SourceCodeObjC];
}

- (NSArray*) groups {

    NSMutableArray* results = [[NSMutableArray alloc] init];
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {

        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXGroup) {
            NSString* name = [obj valueForKey:@"name"];
            NSString* path = [obj valueForKey:@"path"];
            NSArray* children = [obj valueForKey:@"children"];

            Group* group = [[Group alloc] initWithProject:self key:key name:name path:path children:children];
            [results addObject:group];
        }
    }];

    return results;
}

- (NSArray*) targets {

    NSMutableArray* results = [[NSMutableArray alloc] init];
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {

        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXNativeTarget) {

            NSMutableArray* buildFiles = [[NSMutableArray alloc] init];
            for (NSString* buildPhaseKey in [obj objectForKey:@"buildPhases"]) {
                NSDictionary* buildPhase = [[self objects] objectForKey:buildPhaseKey];
                if ([[buildPhase valueForKey:@"isa"] asProjectNodeType] == PBXSourcesBuildPhase) {
                    for (NSString* buildFileKey in [buildPhase objectForKey:@"files"]) {  
                        ProjectFile* targetMember = [self buildFileWithKey:buildFileKey];
                        if (targetMember) {
                            [buildFiles addObject:[self buildFileWithKey:buildFileKey]];
                        }
                    }
                }
            }
            Target* target = [[Target alloc] initWithName:[obj valueForKey:@"name"] members:buildFiles];
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
    [_fileWriteQueue writePendingFilesToDisk];
    [_project writeToFile:[_filePath stringByAppendingPathComponent:@"project.pbxproj"] atomically:YES];
}

/* ================================================== Private Methods =============================================== */
- (NSArray*) projectFilesOfType:(XcodeProjectFileType)projectFileType {
    NSMutableArray* results = [[NSMutableArray alloc] init];
    for (ProjectFile* file in [self projectFiles]) {
        if ([file type] == projectFileType) {
            [results addObject:file];
        }
    }
    return results;
}


- (ProjectFile*) buildFileWithKey:(NSString*)theKey {
    __block ProjectFile* projectFile;
    [[self objects] enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSDictionary* obj, BOOL* stop) {
        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXBuildFile && [key isEqualToString:theKey]) {
            projectFile = [self projectFileWithKey:[obj valueForKey:@"fileRef"]];
        }
    }];
    return projectFile;
}


@end