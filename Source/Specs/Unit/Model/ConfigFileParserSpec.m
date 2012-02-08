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
#import "expanz_codegen_model_ProcessStep.h"
#import "expanz_codegen_utils_ConfigFileParser.h"

SPEC_BEGIN(ConfigFileParserSpec)

    __block ConfigFileParser* parser;

    beforeEach(^{
        parser = [[ConfigFileParser alloc] initWithFilePath:@"/tmp/ToolConfiguration.plist"];
    });


    describe(@"Process Steps", ^{

        it(@"should return the process steps from the config file.", ^{

            NSArray* processSteps = [parser processSteps];
            assertThatInteger([processSteps count], equalToInteger(3));

            ProcessStep* step = [processSteps objectAtIndex:0];
            assertThat(step.stepName, equalTo(@"Project Location"));
            assertThat([step description], notNilValue());
        });


    });

    SPEC_END