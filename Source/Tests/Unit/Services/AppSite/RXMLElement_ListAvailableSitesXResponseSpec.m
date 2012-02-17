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


#import "RXMLElement.h"
#import "RXMLElement+ListAvailableSitesXResponse.h"
#import "expanz_model_AppSite.h"

SPEC_BEGIN(RXMLElement_ListAvailableSitesXResponseSpec)

    describe(@"Parsing response from ListAvailableSites service", ^{

        it(@"should return the AppSites as a collection", ^{
            
            NSString* responseXml = [NSString stringWithTestResource:@"ListAvailableSitesResponse.xml"];
            RXMLElement* element = [RXMLElement elementFromXMLString:responseXml];
            NSArray* appSites = [[element child:@"ListAvailableSitesXResult.ESA.AppSites"] asAppSites];
            [[appSites should] haveCountOf:3];
            for(AppSite* appSite in appSites) {
                LogDebug(@"AppSite: %@", appSite);
            }
            
        });
        
    
    });

SPEC_END