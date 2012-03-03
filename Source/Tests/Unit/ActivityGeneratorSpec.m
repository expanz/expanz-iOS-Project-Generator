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

        beforeEach(^{
            NSString* actvityXml = [NSString stringWithTestResource:@"GetSchemaForActivityXResponse.xml"];
            RXMLElement* element = [RXMLElement elementFromXMLString:actvityXml];
            ActivitySchema* schema = [[element child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];

            NSString* headerTemplate = [NSString stringWithTestResource:@"controllerHeader.mustache"];

            generator = [[ActivityGenerator alloc]
                    initWithSchema:schema headerTemplate:headerTemplate implTemplate:nil xibTemplate:nil];
        });


        it(@"should generate the header file", ^{

            NSString* headerText = [generator headerText];
            LogDebug(@"\n%@", headerText);

        });

        SPEC_END