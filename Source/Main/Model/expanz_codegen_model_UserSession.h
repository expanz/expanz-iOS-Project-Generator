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

@interface expanz_codegen_model_UserSession : NSObject {

@private
    NSMutableArray* _selectedActivities;
}

@property(nonatomic, strong) NSString* projectFilePath;
@property(nonatomic, strong) NSString* selectedSite;

+ (expanz_codegen_model_UserSession*) sharedUserSession;

- (NSArray*) selectedActivities;

- (void) addSelectedActivity:(NSString*)activityId;

@end
/* ================================================================================================================== */
@compatibility_alias UserSession expanz_codegen_model_UserSession;