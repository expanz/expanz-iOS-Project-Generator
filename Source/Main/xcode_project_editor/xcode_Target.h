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

/**
* Represents a target in an xcode project.
*/
@interface xcode_Target : NSObject

@property (nonatomic, strong, readonly) NSString* name;

- (id) initWithName:(NSString*)name;

@end

/* ================================================================================================================== */
@compatibility_alias Target xcode_Target;