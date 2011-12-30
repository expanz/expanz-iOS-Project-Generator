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
#import "../../../Main/expanz_codegen/model/xcode_ClassDefinition.h"

SPEC_BEGIN(ClassDefinitionSpec)

    __block ClassDefinition* classDefinition;

    beforeEach(^{
        classDefinition = [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController"];
        LogDebug(@"Before");
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with a fileName attribute", ^{

            assertThat(classDefinition.className, notNilValue());
            assertThat(classDefinition.className, equalTo(@"ESA_Sales_Browse_ViewController"));

        });

    });


    describe(@"Setting content", ^{

        it(@"should allow setting language to Objective-C", ^{
            [classDefinition setHeader:@"@interface ESA_Sales_Browse_ViewController @end"];
            assertThat(classDefinition.header, equalTo(@"@interface ESA_Sales_Browse_ViewController @end"));
        });

        it(@"should allow setting language to Objective-C", ^{
            [classDefinition setSource:@"@implementation ESA_Sales_Browse_ViewController @end"];
            assertThat(classDefinition.source, equalTo(@"@implementation ESA_Sales_Browse_ViewController @end"));
        });

    });

    describe(@"Setting language", ^{

        it(@"should allow setting language to Objective-C", ^{

            [classDefinition setLanguage:ObjectiveC];
            assertThatBool([classDefinition isObjectiveC], equalToBool(YES));
            assertThatBool([classDefinition isObjectiveCPlusPlus], equalToBool(NO));
        });

        it(@"should allow setting language to Objective-C++", ^{

            [classDefinition setLanguage:ObjectiveCPlusPlus];
            assertThatBool([classDefinition isObjectiveCPlusPlus], equalToBool(YES));
            assertThatBool([classDefinition isObjectiveC], equalToBool(NO));

        });

        it(@"should throw an exception of one of the above languages isn't supplied to setLanguage method", ^{
            @try {
                [classDefinition setLanguage:999];
                [NSException raise:@"Test fails." format:@"Expected exception to be thrown"];
            }
            @catch (NSException* e) {
                assertThat(e.reason, equalTo(@"Language must be one of ObjectiveC, ObjectiveCPlusPlus"));
            }

        });

    });


    SPEC_END