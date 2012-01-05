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
#import "xcode_Project.h"
@class xcode_ProjectFile;

/**
* Marks an `xcode_ProjectFile` as a build resource.
*/
@interface xcode_BuildFile : NSObject {

@private
    NSString* _projectFileKey;
}

@property (nonatomic, weak, readonly) xcode_Project* project;
@property (nonatomic, strong, readonly) NSString* key;

- (id) initWithProject:(xcode_Project*)project key:(NSString*)key projectFileKey:(NSString*)projectFileKey;

- (xcode_ProjectFile*) file; 

@end

/* ================================================================================================================== */
@compatibility_alias BuildFile xcode_BuildFile;