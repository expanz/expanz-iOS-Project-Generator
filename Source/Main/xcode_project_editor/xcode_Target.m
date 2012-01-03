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

#import "xcode_Target.h"


@implementation xcode_Target

@synthesize name = _name;

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)name {
    self = [super init]; 
    if (self) {
        _name = [name copy];
    }
    return self;
}

@end
