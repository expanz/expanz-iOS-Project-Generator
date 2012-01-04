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


#import "SpecHelper.h"
#import "../../Main/xcode_project_editor/XcodeProjectFileType.h"

SPEC_BEGIN(XCodeFileReferenceSpec)

    
    it(@"should return a file reference type from a string", ^{
        assertThatInt([@"sourcecode.c.h" asProjectFileType], equalToInt(SourceCodeHeader));
        assertThatInt([@"sourcecode.c.objc" asProjectFileType], equalToInt(SourceCodeObjC));
    });
    
    it(@"should create a string from a file reference type", ^{
        assertThat([NSString stringFromProjectFileType:SourceCodeHeader], equalTo(@"sourcecode.c.h"));
        assertThat([NSString stringFromProjectFileType:SourceCodeObjC], equalTo(@"sourcecode.c.objc"));
    });
    
    


SPEC_END