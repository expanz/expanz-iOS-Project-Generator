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
@class xcode_FileWriteCache;


@interface xcode_Project : NSObject {

@private
    NSString* _filePath;
    NSMutableDictionary* _project;
    xcode_FileWriteCache* _fileCache;
}

/**
* Creates a new project editor instance with the specified project.pbxproj file.
*/
- (id) initWithFilePath:(NSString*)filePath;

/**
* Lists the header files in an xcode project.
*/
- (NSArray*) headerFiles;

/**
* Lists the implementation files in an xcode project.
*/
- (NSArray*) implementationFiles;

/**
* Lists the groups in an xcode project.
*/
- (NSArray*) groups;

/**
* Returns the file key for the group with the specified name.
*/
- (xcode_Group*) groupWithName:(NSString*)name;

- (void) addClass:(xcode_ClassDefinition*)classDefinition toGroup:(xcode_Group*)group;

/**
* Saves a project after editing.
*/
- (void) save;

@end

/* ================================================================================================================== */
@compatibility_alias Project xcode_Project;