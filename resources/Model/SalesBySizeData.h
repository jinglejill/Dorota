//
//  SalesBySizeData.h
//  SAIM
//
//  Created by Thidaporn Kijkamjai on 11/19/2558 BE.
//  Copyright © 2558 Thidaporn Kijkamjai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesBySizeData : NSObject
@property (retain, nonatomic) NSString * eventID;
@property (retain, nonatomic) NSString * size;
@property (retain, nonatomic) NSString * noOfPair;
@property (retain, nonatomic) NSString * sumValue;
@property (nonatomic) NSInteger intNoOfPair;
@property (nonatomic) float floatSumValue;
@end
