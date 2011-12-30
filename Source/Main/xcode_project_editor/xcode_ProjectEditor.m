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
#import "XcodeProjectNodeType.h"
#import "XcodeFileReferenceType.h"
#import "xcode_ClassDefinition.h"
#import "xcode_FileKeyBuilder.h"


@interface xcode_ProjectEditor (private)

- (NSArray*) fileReferencesOfType:(XcodeFileReferenceType)type;
- (NSMutableDictionary*) objects;

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

- (void) addClass:(xcode_ClassDefinition*)classDefinition {
    //NSString* headerKey = [FileKeyBuilder]


    //[[self objects] setObject:<#(id)anObject#> forKey:<#(id)aKey#>];

}


/* ================================================== Private Methods =============================================== */
- (NSArray*) fileReferencesOfType:(XcodeFileReferenceType)fileReferenceType {
    NSMutableArray* results = [[NSMutableArray alloc] init];

    for (NSString* obj in [[self objects] allValues]) {

        if ([[obj valueForKey:@"isa"] asProjectNodeType] == PBXFileReference &&
            [[obj valueForKey:@"lastKnownFileType"] asFileReferenceType] == fileReferenceType) {
            [results addObject:[obj valueForKey:@"path"]];
        }
    }
    return [results sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];;
}

- (NSMutableDictionary*) objects {
    return [_project objectForKey:@"objects"];
}


@end