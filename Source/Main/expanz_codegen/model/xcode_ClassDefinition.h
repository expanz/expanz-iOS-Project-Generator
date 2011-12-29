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

#import <Foundation/Foundation.h>

typedef enum {
    ObjectiveC,
    ObjectiveCPlusPlus
} ClassDefinitionLanguage;

@interface xcode_ClassDefinition : NSObject

@property (strong, nonatomic, readonly) NSString* className;
@property (nonatomic, readwrite) ClassDefinitionLanguage language;
@property (nonatomic, strong, readwrite) NSString* header;
@property (nonatomic, strong, readwrite) NSString* source;

- (id) initWithName:(NSString*)fileName;

- (BOOL) isObjectiveC;

- (BOOL) isObjectiveCPlusPlus;

@end

/* ================================================================================================================== */
@compatibility_alias ClassDefinition xcode_ClassDefinition;
