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
#import "expanz_codegen_model_ProjectEditor.h"

SPEC_BEGIN(FooSpec)

    __block ProjectEditor* projectEditor;

    beforeEach(^{
        projectEditor = [[ProjectEditor alloc] initWithFilePath:@"/tmp/project.pbxproj"];
    });


    describe(@"Listing source files", ^{

        it(@"should be able to list all the header files in a project.", ^{

            NSArray* headers = [projectEditor headerFiles];
            LogDebug(@"Headers: %@", headers);

            assertThat([headers objectAtIndex:0], equalTo(@"AppDelegate.h"));
            assertThat([headers objectAtIndex:9], equalTo(@"Specs-Prefix.pch"));
            assertThatInteger([headers count], equalToInteger(10));
        });

        it(@"should be able to list all the implementation files in a project", ^{

            NSArray* implementationFiles = [projectEditor implementationFiles];
            LogDebug(@"Implementation Files: %@", implementationFiles);

            assertThat([implementationFiles objectAtIndex:0], equalTo(@"AppDelegate.m"));
            assertThat([implementationFiles objectAtIndex:10], equalTo(@"ProjectNodeType.m"));
            assertThatInteger([implementationFiles count], equalToInteger(11));
        });


    });


    SPEC_END