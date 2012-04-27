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
#import "expanz_model_ActivitySchema.h"
#import "expanz_codegen_model_ViewTemplateRenderer.h"
#import "expanz_codegen_model_GeneratedView.h"
#import "expanz_model_ActivityStyle.h"
#import <XcodeEditor/XcodeEditor.h>


SPEC_BEGIN(ActivityGeneratorSpec)

        __block ViewTemplateRenderer* viewRenderer;
        __block GeneratedView* generatedView;

        describe(@"Generating detail style views", ^{

            beforeEach(^{
                NSString* headerTemplate = [NSString stringWithTestResource:@"detailViewHeader.mustache"];
                NSString* implTemplate = [NSString stringWithTestResource:@"detailViewImpl.mustache"];
                NSString* xibTemplate = [NSString stringWithTestResource:@"detailViewXib.mustache"];

                viewRenderer = [[ViewTemplateRenderer alloc]
                        initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];

                NSString* actvityXml = [NSString stringWithTestResource:@"GetSchemaForActivityXResponse.xml"];
                RXMLElement* element = [RXMLElement elementFromXMLString:actvityXml];
                ActivitySchema* schema = [[element child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];
                generatedView = [[GeneratedView alloc] initWithStyle:[ActivityStyle defaultStyle] schema:schema];
            });


            it(@"should generate the controller class", ^{

                ClassDefinition* classDefinition = [viewRenderer classDefinitionWith:generatedView];
                LogDebug(@"Header: \n%@", [classDefinition header]);
                LogDebug(@"Source: \n%@", [classDefinition source]);

            });

            it(@"should generate the xib file.", ^{

                XibDefinition* xibDefinition = [viewRenderer xibDefinitionWith:generatedView];
                LogDebug(@"Xib: \n%@", [xibDefinition content]);

            });

        });


        describe(@"Generating summary list style views", ^{

            beforeEach(^{
                NSString* headerTemplate = [NSString stringWithTestResource:@"summaryListViewHeader.mustache"];
                NSString* implTemplate = [NSString stringWithTestResource:@"summaryListViewImpl.mustache"];
                NSString* xibTemplate = [NSString stringWithTestResource:@"summaryListViewXib.mustache"];

                viewRenderer = [[ViewTemplateRenderer alloc]
                        initWithHeaderTemplate:headerTemplate implTemplate:implTemplate xibTemplate:xibTemplate];

                NSString* actvityXml = [NSString stringWithTestResource:@"GetSchemaForActivityXResponse.xml"];
                RXMLElement* element = [RXMLElement elementFromXMLString:actvityXml];
                ActivitySchema* schema = [[element child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];
                [[element child:@"GetSchemaForActivityXResult.ESA.Queries"] iterate:@"*" with:^(RXMLElement* e) {
                    [schema addQuery:[e asQuery]];
                }];
                generatedView = [[GeneratedView alloc] initWithStyle:[ActivityStyle browseStyle] schema:schema];
            });


            it(@"should generate the controller class", ^{

                ClassDefinition* classDefinition = [viewRenderer classDefinitionWith:generatedView];
                LogDebug(@"Header: \n%@", [classDefinition header]);
                LogDebug(@"Source: \n%@", [classDefinition source]);

            });

            it(@"should generate the xib file.", ^{

                XibDefinition* xibDefinition = [viewRenderer xibDefinitionWith:generatedView];
                LogDebug(@"Xib: \n%@", [xibDefinition content]);

            });


        });




        SPEC_END