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

#import "XcodeFileReferenceType.h"


@implementation NSDictionary (XCodeFileReferenceType)

+ (NSDictionary*) dictionaryWithFileReferenceTypesAsStrings {
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInteger:SourceCodeHeader], @"sourcecode.c.h",
        [NSNumber numberWithInteger:SourceCodeObjC], @"sourcecode.c.objc",
        nil];
}

@end

@implementation NSString (FileReferenceType)

+ (NSString*) stringFromXcodeFileReferenceType:(XcodeFileReferenceType)type {
    return [[[NSDictionary dictionaryWithFileReferenceTypesAsStrings]
        allKeysForObject:[NSNumber numberWithInteger:type]]
        objectAtIndex:0];
}


- (XcodeFileReferenceType) asXCodeFileReferenceType {
    NSDictionary* typeStrings = [NSDictionary dictionaryWithFileReferenceTypesAsStrings];

    if ([typeStrings objectForKey:self] != nil) {
        return (XcodeFileReferenceType) [[typeStrings objectForKey:self] intValue];
    }
    else {
        return FileReferenceTypeOther;
    }
}

/* ================================================== Private Methods =============================================== */



@end