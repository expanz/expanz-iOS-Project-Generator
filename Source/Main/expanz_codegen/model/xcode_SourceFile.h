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

@interface xcode_SourceFile : NSObject

@property (strong, nonatomic, readonly) NSString* fileName;

- (id) initWithFileName:(NSString*)fileName; 

- (NSString*) fileKey;

@end

/* ================================================================================================================== */
@compatibility_alias SourceFile xcode_SourceFile;
