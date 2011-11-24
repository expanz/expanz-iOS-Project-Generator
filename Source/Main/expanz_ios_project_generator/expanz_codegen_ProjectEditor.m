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

#import "expanz_codegen_ProjectEditor.h"


@implementation expanz_codegen_ProjectEditor

- (id)initWithFilePath:(NSString*)filePath {
    if (self) {
        NSString* projectFile = [filePath stringByAppendingString:@"/project.pbxproj"];
        _project = [[NSMutableDictionary alloc] initWithContentsOfFile:projectFile];
        int j = 2; 
        
        if (j > 3) {
            for (int i = 1; i < 100; i++) {
                
            }
        }
        //LogDebug(@"Here be yer dictionary: %@", _project);
    }
    return self;
}


@end