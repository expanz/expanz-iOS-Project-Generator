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
#import "xcode_Group.h"
#import "xcode_Project.h"
#import "xcode_ClassDefinition.h"
#import "NSString+TestResource.h"
#import "xcode_ProjectFile.h"
#import "xcode_Target.h"

SPEC_BEGIN(GroupSpec)

    __block Project* project;
    __block Group* group;

    beforeEach(^{
        project =
            [[Project alloc] initWithFilePath:@"/Users/jblues/ExpanzProjects/expanz-iOS-SDK/expanz-iOS-SDK.xcodeproj"];
        group = [project groupWithName:@"Main"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with ", ^{
            Group* group =
                [[Group alloc] initWithProject:project key:@"abcd1234" name:@"Main" path:@"Source/Main" children:nil];
            assertThat(group, notNilValue());
            assertThat(group.key, equalTo(@"abcd1234"));
            assertThat(group.name, equalTo(@"Main"));
            assertThat(group.path, equalTo(@"Source/Main"));
            assertThat(group.children, is(empty()));
        });

        it(@"should be able to describe itself.", ^{
            assertThat([group description], equalTo(@"Group: key=6BD47C341484703F000ECE52, path=Source/Main"));
        });

    });


    fdescribe(@"Source files.", ^{

        it(@"should allow adding a source file.", ^{

            ClassDefinition
                * classDefinition = [[ClassDefinition alloc] initWithName:@"ESA_Sales_Foobar_ViewController"];

            [classDefinition setHeader:[NSString stringWithTestResource:@"ESA_Sales_Calc_ViewController.h"]];
            [classDefinition setSource:[NSString stringWithTestResource:@"ESA_Sales_Calc_ViewController.m"]];

            [group addClass:classDefinition];
            [project save];

            ProjectFile* projectFile = [project projectFileWithPath:@"ESA_Sales_Foobar_ViewController.m"];
            assertThat(projectFile, notNilValue());

            Target* examples = [project targetWithName:@"Examples"];
            [examples addMember:projectFile];

            [project save];
            LogDebug(@"Done");

        });
    });


    SPEC_END