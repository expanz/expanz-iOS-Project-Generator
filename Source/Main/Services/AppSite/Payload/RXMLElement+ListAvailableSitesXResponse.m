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
#import "RXMLElement+ListAvailableSitesXResponse.h"
#import "expanz_model_AppSite.h"


@implementation RXMLElement (ListAvailableSitesXResponse)


- (NSArray*) asAppSites {
    if (![self.tag isEqualToString:@"AppSites"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }
    NSArray* children = [self children:@"AppSite"];
    NSMutableArray* appSites = [[NSMutableArray alloc] init];
    for (RXMLElement* element in children) {
        [appSites addObject:[element asAppSite]];
    }
    return [NSArray arrayWithArray:appSites];
}

- (expanz_model_AppSite*) asAppSite {
    if (![self.tag isEqualToString:@"AppSite"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }
    return [[AppSite alloc] initWithAppSiteId:[self attribute:@"id"] name:[self attribute:@"name"]
                           authenticationMode:[self attribute:@"authenticationMode"]];
}


@end