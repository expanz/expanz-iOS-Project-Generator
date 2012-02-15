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


SPEC_BEGIN(ExampleAsyncSpec)

    __block NSString* fetchedData; 

    context(@"Fetching service data", ^{
        it(@"should receive data within one second", ^{

            [[LRResty client] get:@"http://www.example.com" withBlock:^(LRRestyResponse* r) {
                //NSLog(@"That's it! %@", [r asString]);
                fetchedData = [r asString];
            }];

            assertWillHappen(fetchedData != nil);


        });

    });

SPEC_END
