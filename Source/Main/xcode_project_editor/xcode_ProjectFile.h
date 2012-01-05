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
#import "XcodeProjectFileType.h"

@class xcode_Project;


/**
* Represents a file resource in an xcode project.
*/
@interface xcode_ProjectFile : NSObject

@property (nonatomic, weak, readonly) xcode_Project* project;
@property (nonatomic, strong, readonly) NSString* key;
@property (nonatomic, readonly) XcodeProjectFileType type;
@property (nonatomic, strong, readonly) NSString* path; 

- (id) initWithProject:(xcode_Project*)project key:(NSString*)key type:(XcodeProjectFileType)type path:(NSString*)path;

/**
* If yes, indicates the file is able to be included for compilation in an `xcode_Target`.
*/
- (BOOL) isBuildFile;

/**
* Adds this file to the project as an `xcode_BuildFile`, ready to be included in targets.
*/
- (void) becomeBuildFile;

@end

/* ================================================================================================================== */
@compatibility_alias ProjectFile xcode_ProjectFile;