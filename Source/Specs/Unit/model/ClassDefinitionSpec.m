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
#import "xcode_ClassDefinition.h"

SPEC_BEGIN(ClassDefinitionSpec)

    __block ClassDefinition* classDefinition;

    describe(@"Object creation", ^{

        it(@"should allow initialization with a fileName attribute", ^{
            classDefinition = [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController"];
            assertThat(classDefinition.className, notNilValue());
            assertThat(classDefinition.className, equalTo(@"ESA_Sales_Browse_ViewController"));
            assertThatBool(classDefinition.isObjectiveC, equalToBool(YES));
        });

        it(@"should allow initialization with a filename and language attribute", ^{
            classDefinition =
                [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController" language:ObjectiveCPlusPlus];
            assertThatBool(classDefinition.isObjectiveCPlusPlus, equalToBool(YES));
        });

        it(@"should throw an exception if one of the above languages is not specified", ^{
            @try {
                classDefinition =
                    [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController" language:999];
                [NSException raise:@"Test fails." format:@"Expected exception to be thrown"];
            }
            @catch (NSException* e) {
                assertThat(e.reason, equalTo(@"Language must be one of ObjectiveC, ObjectiveCPlusPlus"));
            }
        });

    });

    describe(@"filenames", ^{
        
        it(@"should return the conventional file names for objective-c classes.", ^{
            classDefinition = [[ClassDefinition alloc] initWithName:@"MyClass" language:ObjectiveC];
            assertThat([classDefinition headerFileName], equalTo(@"MyClass.h"));
            assertThat([classDefinition sourceFileName], equalTo(@"MyClass.m"));
        });

        it(@"should return the conventional file names for objective-c++ classes", ^{
            classDefinition = [[ClassDefinition alloc] initWithName:@"MyClass" language:ObjectiveCPlusPlus];
            assertThat([classDefinition headerFileName], equalTo(@"MyClass.h"));
            assertThat([classDefinition sourceFileName], equalTo(@"MyClass.mm"));
        });
    
    });
    

    describe(@"Setting content", ^{

        beforeEach(^{
            classDefinition = [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController"];
        });


        it(@"should allow setting language to Objective-C", ^{
            [classDefinition setHeader:@"@interface ESA_Sales_Browse_ViewController @end"];
            assertThat(classDefinition.header, equalTo(@"@interface ESA_Sales_Browse_ViewController @end"));
        });

        it(@"should allow setting language to Objective-C", ^{
            [classDefinition setSource:@"@implementation ESA_Sales_Browse_ViewController @end"];
            assertThat(classDefinition.source, equalTo(@"@implementation ESA_Sales_Browse_ViewController @end"));
        });

    });



    SPEC_END