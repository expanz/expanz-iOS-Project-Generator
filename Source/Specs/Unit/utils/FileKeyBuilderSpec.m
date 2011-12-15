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

#import "SpecHelper.h"
#import "expanz_codegen_utils_FileKeyBuilder.h"

SPEC_BEGIN(FileKeyBuilderSpec)

    describe(@"md5sum hash", ^{
        
        it(@"Should return an md5 hash for an NSData instnace.", ^{
            
            NSString* toBeHashed = @"ESA_Sales_Customer_Browse_ViewController.h";

            FileKeyBuilder* hashValue = [FileKeyBuilder forFileName:toBeHashed];
            NSString* key = [hashValue build];
            LogDebug(@"Hash value: %@", key);
            assertThat(key, notNilValue());
            assertThatInteger([key length], equalToInteger(25));
        });
        
    
    });


SPEC_END