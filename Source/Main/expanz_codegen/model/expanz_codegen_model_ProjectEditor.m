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

#import "expanz_codegen_model_ProjectEditor.h"
#import "ProjectNodeType.h"
#import "FileReferenceType.h"


@implementation expanz_codegen_model_ProjectEditor

/* ================================================== Initializers ================================================== */
- (id) initWithFilePath:(NSString*)filePath {
    if (self) {
        _project = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) headerFiles {
    NSMutableArray* results = [[[NSMutableArray alloc] init] autorelease];

    NSMutableDictionary* objects = [_project objectForKey:@"objects"];

    for (NSString* keyName in [objects allKeys]) {
        NSDictionary* obj = [objects objectForKey:keyName];

        ProjectNodeType nodeType = [[obj valueForKey:@"isa"] asProjectNodeType];
        FileReferenceType fileReferenceType = [[obj valueForKey:@"lastKnownFileType"] asFileReferenceType];

        if (nodeType == PBXFileReference && fileReferenceType == SourceCodeHeader) {
            [results addObject:[obj valueForKey:@"path"]];
        }
    }
    return [results sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];;
}

- (NSArray*) implementationFiles {
    return nil;
    //To change the template use AppCode | Preferences | File Templates.

}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_project release];
    [super dealloc];
}

@end