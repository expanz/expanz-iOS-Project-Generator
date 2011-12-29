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

#import "xcode_SourceFile.h"
#import "expanz_codegen_utils_FileKeyBuilder.h"

@implementation xcode_SourceFile


@synthesize fileName = _fileName;

/* ================================================== Initializers ================================================== */
- (id) initWithFileName:(NSString*)fileName {
    self = [super init];
    if (self) {
        _fileName = [fileName copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) fileKey {
    return [[FileKeyBuilder forFileName:_fileName] build];
}


@end
