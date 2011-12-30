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


@interface xcode_ProjectEditor : NSObject  {

@private
    NSMutableDictionary* _project;

}

- (id) initWithFilePath:(NSString*)filePath;

- (NSArray*) headerFiles;

- (NSArray*) implementationFiles;

- (void) addClass:(xcode_ClassDefinition*)classDefinition;

@end

/* ================================================================================================================== */
@compatibility_alias ProjectEditor xcode_ProjectEditor;