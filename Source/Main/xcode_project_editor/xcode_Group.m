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

#import "xcode_Group.h"
#import "xcode_Project.h"

@implementation xcode_Group


@synthesize name = _name;
@synthesize path = _path;
@synthesize key = _key;
@synthesize children = _children;


/* ================================================== Initializers ================================================== */
- (id) initWithKey:(NSString*)key name:(NSString*)name path:(NSString*)path children:(NSArray*)children {
    self = [super init]; 
    if (self) {
        _key = [key copy];
        _name = [name copy];
        _path = [path copy];
        _children = [[NSMutableArray alloc] init];
        [_children addObjectsFromArray:children];
    }
    return self;
}

- (void) addChildWithKey:(NSString*)key {

    if (![_children containsObject:key]) {
        [_children addObject:key];
    }
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Group: key=%@, name=%@", _key, _name];
}


@end