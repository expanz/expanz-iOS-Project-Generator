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

#import "GRArrayIndexHelper.h"

/* ================================================================================================================== */
#pragma mark - GRWrappedArrayElement

@interface GRWrappedArrayElement : NSObject
@property(nonatomic, strong) NSString* indexKey;
@property(nonatomic, strong) id element;
@property(nonatomic) NSUInteger index;
@end

@implementation GRWrappedArrayElement
@synthesize indexKey = _indexKey;
@synthesize element = _element;
@synthesize index = _index;

- (id) valueForKey:(NSString*)key {
    // Index? Got it :-)
    if ([key isEqualToString:_indexKey]) {
        return [NSNumber numberWithUnsignedInteger:_index];
    }
    return [_element valueForKey:key];
}

@end

/* ================================================================================================================== */
#pragma mark - GRArrayWrapperContext

@interface GRArrayWrapperContext : NSObject
@property(nonatomic, strong) NSString* indexKey;
@property(nonatomic, strong) id wrappedContext;
@end

@implementation GRArrayWrapperContext
@synthesize indexKey = _indexKey;
@synthesize wrappedContext = _wrappedContext;

- (id) valueForKey:(NSString*)key {
    id value = [_wrappedContext valueForKey:key];

    if ([value isKindOfClass:[NSArray class]]) {
        // return an Array whose items are GRWrappedArrayElement
        NSMutableArray* array = [NSMutableArray array];
        NSUInteger index = 0;
        for (id element in (NSArray*) value) {
            GRWrappedArrayElement* wrappedArrayElement = [[GRWrappedArrayElement alloc] init];
            wrappedArrayElement.element = element;
            wrappedArrayElement.index = index;
            wrappedArrayElement.indexKey = _indexKey;
            [array addObject:wrappedArrayElement];
            index++;
        }
        value = array;
    }

    return value;
}

@end

/* ================================================================================================================== */
#pragma mark - GRArrayIndexHelper

@interface GRArrayIndexHelper ()
@property(nonatomic, copy) NSString* indexKey;
@end

@implementation GRArrayIndexHelper
@synthesize indexKey = _indexKey;

+ (id) helperWithIndexKey:(NSString*)indexKey {
    GRArrayIndexHelper* helper = [[self alloc] init];
    helper.indexKey = indexKey;
    return helper;
}

#pragma mark <GRMustacheHelper>

- (NSString*) renderSection:(GRMustacheSection*)section withContext:(id)context {
    if (_indexKey.length > 0) {
        // Let's replace the current context with a GRArrayWrapperContext
        // that will rewrite arrays.
        GRArrayWrapperContext* arrayWrapperContext = [[GRArrayWrapperContext alloc] init];
        arrayWrapperContext.wrappedContext = context;
        arrayWrapperContext.indexKey = _indexKey;
        context = arrayWrapperContext;
    }

    return [section renderObject:context];
}

@end
