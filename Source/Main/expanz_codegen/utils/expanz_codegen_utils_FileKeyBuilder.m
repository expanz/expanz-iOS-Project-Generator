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

#import "expanz_codegen_utils_FileKeyBuilder.h"

@implementation expanz_codegen_utils_FileKeyBuilder

/* ================================================= Class Methods ================================================== */
+ (expanz_codegen_utils_FileKeyBuilder*) forFileName:(NSString*)fileName {
    NSData* data = [fileName dataUsingEncoding:NSUTF8StringEncoding];
    return [[[expanz_codegen_utils_FileKeyBuilder alloc] initHashValueMD5HashWithBytes:[data bytes] length:[data length]]
        autorelease];
}

/* ================================================== Initializers ================================================== */
- (id) initHashValueMD5HashWithBytes:(const void*)bytes length:(NSUInteger)length {
    self = [super init];
    if (self != nil) {
        CC_MD5(bytes, (int) length, _value);
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) build {
    NSInteger byteLength = sizeof(HashValueMD5Hash);
    NSMutableString* stringValue = [NSMutableString stringWithCapacity:byteLength * 2];
    NSInteger i;
    for (i = 0; i < byteLength; i++) {
        [stringValue appendFormat:@"%02x", _value[i]];
    }
    return [stringValue substringToIndex:25];
}


@end
