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

#import "expanz_iOS_SdkConfiguration.h"


SPEC_BEGIN(SdkConfigurationSpec)

    describe(@"Reading configuration.xml file", ^{

        it(@"should parse the baseUrl, preferredSite and authenticationMethod properties", ^{

            NSString* xmlConfig = [NSString stringWithTestResource:@"production_environment.xml"];
            SdkConfiguration* configuration = [[SdkConfiguration alloc] initWithXmlString:xmlConfig];

            [[[configuration baseUrl] should] equal:@"http://expanzdemo.cloudapp.net:8080/ESAService.svc/restish"];
            [[[configuration preferredSite] should] equal:@"SALES"];
            [[[configuration userType] should] equal:@"Alternate"];
        });

    });

SPEC_END