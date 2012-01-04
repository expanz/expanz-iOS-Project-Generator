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

#import "xcode_Group.h"
#import "xcode_Project.h"
#import "xcode_ClassDefinition.h"
#import "XcodeProjectFileType.h"
#import "xcode_KeyBuilder.h"
#import "xcode_FileWriteQueue.h"

@interface xcode_Group (private)

- (void) addChildWithKey:(NSString*)key;

- (NSDictionary*) makeFileReference:(NSString*)name type:(XcodeProjectFileType)type;

@end

@implementation xcode_Group

@synthesize project = _project;
@synthesize name = _name;
@synthesize path = _path;
@synthesize key = _key;
@synthesize children = _children;


/* ================================================== Initializers ================================================== */
- (id) initWithKey:(NSString*)key name:(NSString*)name path:(NSString*)path children:(NSArray*)children {
    self = [super init];
    if (self) {
        _key = [key copy];
        _name = [name copy];
        _path = [path copy];
        _children = [[NSMutableArray alloc] init];
        [_children addObjectsFromArray:children];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) addClass:(ClassDefinition*)classDefinition {
    NSDictionary* header = [self makeFileReference:[classDefinition headerFileName] type:SourceCodeHeader];
    NSString* headerKey = [[KeyBuilder forFileName:[classDefinition headerFileName]] build];
    [[_project objects] setObject:header forKey:headerKey];

    NSDictionary* source = [self makeFileReference:[classDefinition sourceFileName] type:SourceCodeObjC];
    NSString* sourceKey = [[KeyBuilder forFileName:[classDefinition sourceFileName]] build];
    [[_project objects] setObject:source forKey:sourceKey];

    [self addChildWithKey:headerKey];
    [self addChildWithKey:sourceKey];

    NSMutableDictionary* groupData = [[NSMutableDictionary alloc] init];
    [groupData setObject:@"PBXGroup" forKey:@"isa"];
    [groupData setObject:@"<group>" forKey:@"sourceTree"];
    [groupData setObject:_name forKey:@"name"];
    [groupData setObject:_path forKey:@"path"];
    [groupData setObject:_children forKey:@"children"];
    [[_project objects] setObject:groupData forKey:_key];

    [_project.pendingFiles
        queueFile:[classDefinition headerFileName] inDirectory:_path withContents:[classDefinition header]];
    [_project.pendingFiles
        queueFile:[classDefinition sourceFileName] inDirectory:_path withContents:[classDefinition source]];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Group: key=%@, name=%@", _key, _name];
}

/* ================================================== Private Methods =============================================== */
- (void) addChildWithKey:(NSString*)key {
    if (![_children containsObject:key]) {
        [_children addObject:key];
    }
}

- (NSDictionary*) makeFileReference:(NSString*)name type:(XcodeProjectFileType)type {
    NSMutableDictionary* reference = [[NSMutableDictionary alloc] init];
    [reference setObject:@"PBXFileReference" forKey:@"isa"];
    [reference setObject:@"4" forKey:@"FileEncoding"];
    [reference setObject:[NSString stringFromProjectFileType:type] forKey:@"lastKnownFileType"];
    [reference setObject:name forKey:@"path"];
    [reference setObject:@"<group>" forKey:@"sourceTree"];
    return reference;
}


@end