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
#import "expanz_codegen_model_GeneratedSource.h"

SPEC_BEGIN(GeneratedSourceSpec)

    __block GeneratedSource* sourceFile;

    beforeEach(^{
        sourceFile = [[GeneratedSource alloc] initWithFileName:@"ESA_Sales_Browse_ViewController.h"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with a fileName attribute", ^{

            assertThat(sourceFile.fileName, notNilValue());
            assertThat(sourceFile.fileName, equalTo(@"ESA_Sales_Browse_ViewController.h"));

        });

    });

    describe(@"File key", ^{

        it(@"should return a 20 character hash corresponding to the fileName", ^{

            assertThat([sourceFile fileKey], notNilValue());
            assertThatInteger([[sourceFile fileKey] length], equalToInteger(25));

        });

    });



    SPEC_END