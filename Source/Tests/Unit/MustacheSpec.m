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

#import "expanz_model_FieldSchema.h"
#import "GRMustacheTemplate.h"

SPEC_BEGIN(MustacheSpec)

        it(@"should render templates", ^{

            GRMustacheTemplate* template;
            NSString* result;
            NSError* error = [[NSError alloc] init];

            template = [GRMustacheTemplate templateFromString:@"{{name}}" error:&error];
            FieldSchema* fieldSchema =
                    [[FieldSchema alloc] initWithName:@"FirstName" expanzType:@"StringEx" label:@"Customer First Name"];

            result = [template renderObjects:fieldSchema];

            LogDebug(@"Result: %@", result);
            LogDebug(@"Error: %@", [error userInfo]);


        });

        SPEC_END


