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
#import "expanz_codegen_ProjectEditor.h"

SPEC_BEGIN(FooSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with a file path to an XCode project", ^{
            ProjectEditor* projectEditor = [[ProjectEditor alloc]
                initWithFilePath:@"/Users/jblues/ExpanzProjects/expanz-iOS-Project-Generator/expanz-iOS-Project-Generator.xcodeproj"];

        });
    });


SPEC_END