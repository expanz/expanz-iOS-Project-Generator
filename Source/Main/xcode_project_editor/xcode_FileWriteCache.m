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

#import "xcode_FileWriteCache.h"


@implementation xcode_FileWriteCache

/* ================================================== Initializers ================================================== */
- (id) initWithBaseDirectory:(NSString*)baseDirectory {
    self = [super init];
    if (self) {
        _data = [[NSMutableDictionary alloc] init];
        _baseDirectory = [baseDirectory copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) spool:(NSString*)fileName inDirectory:(NSString*)directory contents:(NSString*)contents {
    [_data setObject:contents forKey:[[_baseDirectory stringByAppendingPathComponent:directory]
                                           stringByAppendingPathComponent:fileName]];
}

- (void) writePendingFilesToDisk {
    [_data enumerateKeysAndObjectsUsingBlock:^(id filePath, id data, BOOL* stop) {
        NSError* error;
        [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            LogDebug(@"Error writing file: %@", error);
        }
    }];
    [self discardAll];
}

- (void) discardAll {
    [_data removeAllObjects];

}


@end