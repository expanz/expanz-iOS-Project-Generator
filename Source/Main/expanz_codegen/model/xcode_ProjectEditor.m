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

#import "xcode_ProjectEditor.h"
#import "ProjectNodeType.h"
#import "FileReferenceType.h"

@interface xcode_ProjectEditor (private)

- (NSArray*) fileReferencesOfType:(FileReferenceType)type;

@end


@implementation xcode_ProjectEditor

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    if (self) {
        _project = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) headerFiles {
    return [self fileReferencesOfType:SourceCodeHeader];
}

- (NSArray*) implementationFiles {
    return [self fileReferencesOfType:SourceCodeObjC];
}

/* ================================================== Private Methods =============================================== */
- (NSArray*) fileReferencesOfType:(FileReferenceType)fileReferenceType {
    NSMutableArray* results = [[NSMutableArray alloc] init];

    NSMutableDictionary* objects = [_project objectForKey:@"objects"];

    for (NSString* keyName in [objects allKeys]) {
        NSDictionary* obj = [objects objectForKey:keyName];

        ProjectNodeType nodeType = [[obj valueForKey:@"isa"] asProjectNodeType];

        if (nodeType == PBXFileReference && fileReferenceType ==
            [[obj valueForKey:@"lastKnownFileType"] asFileReferenceType]) {
            [results addObject:[obj valueForKey:@"path"]];
        }
    }
    return [results sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];;
}


@end