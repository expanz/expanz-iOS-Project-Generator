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


@interface xcode_FileWriteCache : NSObject {

@private

    NSString* _baseDirectory;
    NSMutableDictionary* _data;
}

- (id) initWithBaseDirectory:(NSString*)baseDirectory;

- (void) queueString:(NSString*)string withFileName:(NSString*)fileName inDirectory:(NSString*)directory;

- (void) spool:(NSString*)fileName inDirectory:(NSString*)directory contents:(NSString*)contents;

- (void) writePendingFilesToDisk;

- (void) discardAll;


@end

/* ================================================================================================================== */
@compatibility_alias FileWriteCache xcode_FileWriteCache;