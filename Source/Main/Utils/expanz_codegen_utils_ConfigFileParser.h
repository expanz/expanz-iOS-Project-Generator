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


@interface expanz_codegen_utils_ConfigFileParser : NSObject

@property(nonatomic, strong, readonly) NSDictionary* configs;

- (id) initWithFilePath:(NSString*)filePath;

- (NSArray*) processSteps;

@end
/* ================================================================================================================== */
@compatibility_alias ConfigFileParser expanz_codegen_utils_ConfigFileParser;
