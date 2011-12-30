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


#import "XcodeProjectNodeType.h"

@implementation NSString (ProjectNode)

- (XcodeProjectNodeType)asProjectNodeType {

    NSDictionary *nodes = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInteger:PBXBuildFile], @"PBXBuildFile",
            [NSNumber numberWithInteger:PBXContainerItemProxy], @"PBXContainerItemProxy",
            [NSNumber numberWithInteger:PBXCopyFilesBuildPhase], @"PBXCopyFilesBuildPhase",
            [NSNumber numberWithInteger:PBXFileReference], @"PBXFileReference",
            [NSNumber numberWithInteger:PBXFrameworksBuildPhase], @"PBXFrameworksBuildPhase",
            [NSNumber numberWithInteger:PBXGroup], @"PBXGroup",
            [NSNumber numberWithInteger:PBXNativeTarget], @"PBXNativeTarget",
            [NSNumber numberWithInteger:PBXProject], @"PBXProject",
            [NSNumber numberWithInteger:PBXResourcesBuildPhase], @"PBXResourcesBuildPhase",
            [NSNumber numberWithInteger:PBXSourcesBuildPhase], @"PBXSourcesBuildPhase",
            [NSNumber numberWithInteger:PBXTargetDependency], @"PBXTargetDependency",
            [NSNumber numberWithInteger:PBXVariantGroup], @"PBXVariantGroup",
            [NSNumber numberWithInteger:XCBuildConfiguration], @"XCBuildConfiguration",
            [NSNumber numberWithInteger:XCConfigurationList], @"XCConfigurationList",
            nil];

    return (XcodeProjectNodeType) [[nodes objectForKey:self] intValue];
}


@end