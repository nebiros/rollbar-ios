//  Copyright (c) 2018 Rollbar, Inc. All rights reserved.

#import <XCTest/XCTest.h>
#import "../Rollbar/Rollbar.h"
#import "RollbarTestUtil.h"

@interface RollbarTests : XCTestCase

@end

@implementation RollbarTests

- (void)setUp {
    [super setUp];
    RollbarClearLogFile();
    if (!Rollbar.currentConfiguration) {
        [Rollbar initWithAccessToken:@""];
        
        [Rollbar initWithAccessToken:@"2ffc7997ed864dda94f63e7b7daae0f3"];
        Rollbar.currentConfiguration.accessToken = @"2ffc7997ed864dda94f63e7b7daae0f3";
        Rollbar.currentConfiguration.environment = @"unit-tests";
        Rollbar.currentConfiguration.transmit = YES;
        Rollbar.currentConfiguration.logPayload = YES;
        [Rollbar.currentConfiguration setReportingRate:5000];

    }
}

- (void)tearDown {
    [Rollbar updateConfiguration:[RollbarConfiguration configuration] isRoot:true];
    [super tearDown];
}

- (void)testRollbarTransmit {

    Rollbar.currentConfiguration.accessToken = @"2ffc7997ed864dda94f63e7b7daae0f3";
    Rollbar.currentConfiguration.environment = @"unit-tests";
    Rollbar.currentConfiguration.transmit = YES;

    Rollbar.currentConfiguration.transmit = YES;
    [Rollbar critical:@"Transmission test YES"];
    [NSThread sleepForTimeInterval:2.0f];

    Rollbar.currentConfiguration.transmit = NO;
    [Rollbar critical:@"Transmission test NO"];
    [NSThread sleepForTimeInterval:2.0f];

    Rollbar.currentConfiguration.transmit = YES;
    //Rollbar.currentConfiguration.enabled = NO;
    [Rollbar critical:@"Transmission test YES2"];
    [NSThread sleepForTimeInterval:2.0f];
    
    int count = 50;
    while (count > 0) {
        [Rollbar critical:[NSString stringWithFormat: @"Rate Limit Test %i", count]];
         
        [NSThread sleepForTimeInterval:1.0f];
        
        count--;
    }
}

- (void)testNotification {
    NSDictionary *notificationText = @{
                                       @"error": @[@"testing-error-with-message", [NSException exceptionWithName:@"testing-error" reason:@"testing-error-2" userInfo:nil]],
                                       @"debug": @[@"testing-debug"],
                                       @"error": @[@"testing-error"],
                                       @"info": @[@"testing-info"],
                                       @"critical": @[@"testing-critical"]
                                       };
    
    for (NSString *type in notificationText.allKeys) {
        NSArray *params = notificationText[type];
        if ([type isEqualToString:@"error"]) {
            if (params.count == 2) {
                [Rollbar error:params[0] exception:params[1]];
            } else {
                [Rollbar error:params[0]];
            }
        } else if ([type isEqualToString:@"debug"]) {
            [Rollbar debug:params[0]];
        } else if ([type isEqualToString:@"info"]) {
            [Rollbar info:params[0]];
        } else if ([type isEqualToString:@"critical"]) {
            [Rollbar critical:params[0]];
        }
    }

    //[NSThread sleepForTimeInterval:3.0f];

    NSArray *items = RollbarReadLogItemFromFile();
    for (id item in items) {
        NSString *level = [item valueForKeyPath:@"level"];
        NSString *message = [item valueForKeyPath:@"body.message.body"];
        NSArray *params = notificationText[level];
        if ([level isEqualToString:@"debug"]) {
            XCTAssertTrue([params[0] isEqualToString:message], @"Expects '%@', got '%@'.", params[0], message);
        } else if ([level isEqualToString:@"error"]) {
            if (params.count == 2) {
                NSException *exception = params[1];
                XCTAssertTrue(exception != nil);
//                NSString *errMsg = [NSString stringWithFormat:@"%@\r\r%@\r\r%@", params[0], exception.reason, [exception.callStackSymbols componentsJoinedByString:@"\n"]];
//                XCTAssertTrue([errMsg isEqualToString:message], @"Expects '%@', got '%@'.", errMsg, message);
            } else {
                XCTAssertTrue([params[0] isEqualToString:message], @"Expects '%@', got '%@'.", params[0], message);
            }
        } else if ([level isEqualToString:@"info"]) {
            XCTAssertTrue([params[0] isEqualToString:message], @"Expects '%@', got '%@'.", params[0], message);
        } else if ([level isEqualToString:@"critical"]) {
            XCTAssertTrue([params[0] isEqualToString:message], @"Expects '%@', got '%@'.", params[0], message);
        }
    }
}

@end
