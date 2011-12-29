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

    __block ClassDefinition* sourceFile;

    beforeEach(^{
        sourceFile = [[ClassDefinition alloc] initWithName:@"ESA_Sales_Browse_ViewController.h"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with a fileName attribute", ^{

            assertThat(sourceFile.className, notNilValue());
            assertThat(sourceFile.className, equalTo(@"ESA_Sales_Browse_ViewController.h"));

        });

    });

    describe(@"Setting language", ^{

        it(@"should allow setting language to Objective-C", ^{
            
            [sourceFile setLanguage:ObjectiveC];
            assertThatBool([sourceFile isObjectiveC], equalToBool(YES));
            assertThatBool([sourceFile isObjectiveCPlusPlus], equalToBool(NO));
        });
        
        it(@"should allow setting language to Objective-C++", ^{
            
            [sourceFile setLanguage:ObjectiveCPlusPlus];
            assertThatBool([sourceFile isObjectiveCPlusPlus], equalToBool(YES));
            assertThatBool([sourceFile isObjectiveC], equalToBool(NO));
            
        });
        
        it(@"should throw an exception of one of the above languages isn't supplied to setLanguage method", ^{
            @try {
                [sourceFile setLanguage:999];
                [NSException raise:@"Test fails." format:@"Expected exception to be thrown"];
            }
            @catch (NSException* e) {
                assertThat(e.reason, equalTo(@"Language must be one of ObjectiveC, ObjectiveCPlusPlus"));
            }
            
        });


    });


    SPEC_END