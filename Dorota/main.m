//
//  main.m
//  Dorota
//
//  Created by Thidaporn Kijkamjai on 12/8/2560 BE.
//  Copyright © 2560 Appxelent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSArray *globalMessage;
NSString *globalPingAddress;
NSString *globalDomainName;
NSString *globalSubjectNoConnection;
NSString *globalDetailNoConnection;
BOOL globalRotateFromSeg;
BOOL globalFinishLoadSharedData;
NSString *globalCipher;
NSString *globalModifiedUser;
NSNumberFormatter *formatterBaht;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
