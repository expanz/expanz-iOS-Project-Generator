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

@implementation NSString (FileReferenceType)

- (XcodeFileReferenceType) asFileReferenceType {
    NSDictionary* nodes = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInteger:SourceCodeHeader], @"sourcecode.c.h",
        [NSNumber numberWithInteger:SourceCodeObjC], @"sourcecode.c.objc",
        nil];


    XcodeFileReferenceType referenceType;

    if ([nodes objectForKey:self] != nil) {
        referenceType = (XcodeFileReferenceType) [[nodes objectForKey:self] intValue];
    }
    else {
        referenceType = FileReferenceTypeOther;
    }
    return referenceType;
}


@end