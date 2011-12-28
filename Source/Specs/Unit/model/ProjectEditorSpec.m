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


    describe(@"Listing headers", ^{

        it(@"should be able to list all the files in a project.", ^{

            NSArray* headers = [projectEditor headerFiles];
            LogDebug(@"Headers: %@", headers);

            assertThat([headers objectAtIndex:0], equalTo(@"AppDelegate.h"));
            assertThat([headers objectAtIndex:9], equalTo(@"Specs-Prefix.pch"));
            assertThatInteger([headers count], equalToInteger(10));

        });


    });


    SPEC_END