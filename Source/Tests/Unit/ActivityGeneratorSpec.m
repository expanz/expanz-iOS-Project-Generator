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

#import "RXMLElement+SiteDetails.h"
#import "expanz_codegen_model_ActivityGenerator.h"

SPEC_BEGIN(ActivityGeneratorSpec)

        __block ActivityGenerator* generator;
        __block ActivitySchema* schema;

        beforeEach(^{
            NSString* actvityXml = [NSString stringWithTestResource:@"GetSchemaForActivityXResponse.xml"];
            RXMLElement* element = [RXMLElement elementFromXMLString:actvityXml];
            schema = [[element child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];

            NSString* headerTemplate = [NSString stringWithTestResource:@"controllerHeader.mustache"];
            NSString* implTemplate = [NSString stringWithTestResource:@"controllerImpl.mustache"];
            NSString* xibTemplate = [NSString stringWithTestResource:@"uiFile.mustache"];

            generator = [[ActivityGenerator alloc]
                    initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];
        });


        it(@"should generate the header file", ^{

            NSString* headerText = [generator headerForSchema:schema controllerClassName:@"Foobar"];
            LogDebug(@"\n%@", headerText);

        });

        it(@"should generate the impl file.", ^{

            NSString* implText = [generator implementationForSchema:schema controllerClassName:@"Foobar"];
            LogDebug(@"\n%@", implText);

        });

        it(@"should generate the xib file.", ^{

            NSString* xibText = [generator xibForSchema:schema controllerClassName:@"Foobar"];
            LogDebug(@"\n%@", xibText);

        });




        SPEC_END