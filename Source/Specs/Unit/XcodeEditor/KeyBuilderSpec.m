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
#import "xcode_KeyBuilder.h"

SPEC_BEGIN(KeyBuilderSpec)


    describe(@"md5sum hash", ^{
        
        it(@"Should return an md5 hash for an NSData instnace.", ^{
            
            NSString* requiresKey = @"ESA_Sales_Customer_Browse_ViewController.h";

            KeyBuilder* builtKey = [KeyBuilder forItemNamed:requiresKey];
            NSString* key = [builtKey build];
            LogDebug(@"Key: %@", key);
            assertThat(key, notNilValue());
            assertThatInteger([key length], equalToInteger(24));
        });
        
    
    });


SPEC_END