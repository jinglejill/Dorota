//
//  PreOrderEventIDHistory.h
//  SAIM_TEST
//
//  Created by Thidaporn Kijkamjai on 8/2/2560 BE.
//  Copyright © 2560 Thidaporn Kijkamjai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreOrderEventIDHistory : NSObject
@property (nonatomic) NSInteger preOrderEventIDHistoryID;
@property (nonatomic) NSInteger receiptProductItemID;
@property (nonatomic) NSInteger preOrderEventID;
@property (retain, nonatomic) NSString * modifiedDate;
@property (retain, nonatomic) NSString * modifiedUser;//ใช้ตอน delete row ที่ duplicate key
@property (nonatomic) NSInteger replaceSelf;//ใช้เฉพาะตอน push type = 'd'
@property (nonatomic) NSInteger idInserted;//ใช้ตอน update or delete
-(PreOrderEventIDHistory *)initWithReceiptProductItemID:(NSInteger)receiptProductItemID preOrderEventID:(NSInteger)preOrderEventID;
+(void)addObject:(PreOrderEventIDHistory*)preOrderEventIDHistory;
+(NSMutableArray *)getHistoryWithReceiptProductItemID:(NSInteger)ReceiptProductItemID;
@end
