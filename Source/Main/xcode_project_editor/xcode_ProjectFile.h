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


/**
* Represents a file resource in an xcode project.
*/
@interface xcode_ProjectFile : NSObject

@property (nonatomic, strong, readonly) NSString* key;
@property (nonatomic, readonly) XcodeProjectFileType type;
@property (nonatomic, strong, readonly) NSString* path; 

- (id) initWithKey:(NSString*)key type:(XcodeProjectFileType)type path:(NSString*)path;

@end

/* ================================================================================================================== */
@compatibility_alias ProjectFile xcode_ProjectFile;