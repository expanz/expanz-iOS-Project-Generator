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

@class xcode_Project;

/**
* Represents a target in an xcode project.
*/
@interface xcode_Target : NSObject

@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic, strong, readonly) NSArray* buildFiles; 

- (id) initWithName:(NSString*)name buildFiles:(NSArray*)buildFiles;


@end

/* ================================================================================================================== */
@compatibility_alias Target xcode_Target;