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
#import <Foundation/Foundation.h>

@class xcode_ClassDefinition;
@class xcode_Group;
@class xcode_FileWriteQueue;


@interface xcode_Project : NSObject {

@private
    NSString* _filePath;
    NSMutableDictionary* _project;
}

@property (nonatomic, strong, readonly) xcode_FileWriteQueue* pendingFiles;

/**
* Creates a new project editor instance with the specified project.pbxproj file.
*/
- (id) initWithFilePath:(NSString*)filePath;

/**
* Raw project data.
*/
- (NSMutableDictionary*) objects;

- (NSArray*) files;

/**
* Lists the header files in an xcode project.
*/
- (NSArray*) headerFiles;

/**
* Lists the implementation files in an xcode project.
*/
- (NSArray*) implementationFiles;

/**
* Lists the groups in an xcode project, returning an array of `xcode_Group` objects.
*/
- (NSArray*) groups;

/**
* Lists the targets in an xcode project, returning an array of `xcode_Target` objects.
*/
- (NSArray*) targets;

/**
* Returns the file key for the group with the specified name.
*/
- (xcode_Group*) groupWithName:(NSString*)name;

/**
* Saves a project after editing.
*/
- (void) save;

@end

/* ================================================================================================================== */
@compatibility_alias Project xcode_Project;