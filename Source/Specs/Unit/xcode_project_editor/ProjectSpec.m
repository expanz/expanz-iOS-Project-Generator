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
#import "../../../Main/xcode_project_editor/xcode_Project.h"
#import "xcode_ClassDefinition.h"
#import "xcode_Group.h"

SPEC_BEGIN(FooSpec)

    __block Project* projectEditor;

    beforeEach(^{
        projectEditor = [[Project alloc] initWithFilePath:@"/tmp"];
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

    describe(@"Groups", ^{

        it(@"should be able to list all of the groups in a project", ^{
            NSArray* groups = [projectEditor groups];
            assertThat(groups, notNilValue());
            assertThat(groups, isNot(empty()));
            LogDebug(@"Groups: %@", groups);
        });

    });

    describe(@"Adding a source file.", ^{

        it(@"should allow adding a source file to the project.", ^{

            projectEditor = [[Project alloc]
                initWithFilePath:@"/Users/jblues/ExpanzProjects/expanz-iOS-SDK/expanz-iOS-SDK.xcodeproj"];

            ClassDefinition* classDefinition = [[ClassDefinition alloc] initWithName:@"ESA_Foobar_ViewController"];
            [classDefinition setHeader:@"@interface ESA_Foobar_ViewController @end"];
            [classDefinition setSource:@"@implementation ESA_Foobar_ViewController @end"];

            Group* group = [projectEditor groupWithName:@"Main"];
            NSArray* groups = [projectEditor groups];
            LogDebug(@"%@", groups);


            assertThat(group, notNilValue());
            [projectEditor addClass:classDefinition toGroup:group];
            [projectEditor save];

            LogDebug(@"Done");

        });



    });


    SPEC_END