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
#import "xcode_Project.h"
#import "xcode_Target.h"

SPEC_BEGIN(FooSpec)

    __block Project* project;

    beforeEach(^{
        project = [[Project alloc] initWithFilePath:@"/tmp"];
    });


    describe(@"Listing source files", ^{

        it(@"should be able to list all the header files in a project.", ^{

            NSArray* headers = [project headerFiles];
            LogDebug(@"Headers: %@", headers);

            assertThat([[headers objectAtIndex:0] path], equalTo(@"AppDelegate.h"));
            assertThat([[headers objectAtIndex:9] path], equalTo(@"expanz_codegen_utils_FileKeyBuilder.h"));
            assertThatInteger([headers count], equalToInteger(10));
        });

        it(@"should be able to list all the implementation files in a project", ^{

            NSArray* implementationFiles = [project implementationFiles];
            LogDebug(@"Implementation Files: %@", implementationFiles);

            assertThat([[implementationFiles objectAtIndex:0] path], equalTo(@"AppDelegate.m"));
            assertThat([[implementationFiles objectAtIndex:10] path], equalTo(@"main.m"));
            assertThatInteger([implementationFiles count], equalToInteger(11));
        });

    });

    describe(@"Groups", ^{

        it(@"should be able to list all of the groups in a project", ^{
            NSArray* groups = [project groups];
            assertThat(groups, notNilValue());
            assertThat(groups, isNot(empty()));
            LogDebug(@"Groups: %@", groups);
        });

    });

    describe(@"Targets", ^{

        it(@"should be able to list the targets in an xcode project", ^{

            NSArray* targets = [project targets];
            for (Target* target in [project targets]) {
                LogDebug(@"%@", target);
            }
            assertThat(targets, notNilValue());
            assertThat(targets, isNot(empty()));

        });


    });



    SPEC_END