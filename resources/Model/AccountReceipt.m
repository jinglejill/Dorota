//
//  AccountReceipt.m
//  SAIM_TEST
//
//  Created by Thidaporn Kijkamjai on 2/8/2560 BE.
//  Copyright © 2560 Thidaporn Kijkamjai. All rights reserved.
//

#import "AccountReceipt.h"

@implementation AccountReceipt

-(AccountReceipt *)initWithAccountReceiptID:(NSInteger)accountReceiptID runningAccountReceiptHistory:(NSInteger)runningAccountReceiptHistory runningReceiptNo:(NSInteger)runningReceiptNo accountReceiptHistoryDate:(NSString*)accountReceiptHistoryDate receiptNo:(NSString*)receiptNo receiptDate:(NSString*)receiptDate receiptID:(NSInteger)receiptID receiptDiscount:(float)receiptDiscount
{
    self = [super init];
    if(self)
    {
        self.accountReceiptID = accountReceiptID;
        self.runningAccountReceiptHistory = runningAccountReceiptHistory;
        self.runningReceiptNo = runningReceiptNo;
        self.accountReceiptHistoryDate = accountReceiptHistoryDate;
        self.receiptNo = receiptNo;
        self.receiptDate = receiptDate;
        self.receiptID = receiptID;
        self.receiptDiscount = receiptDiscount;
    }
    
    return self;
}

+(NSMutableArray *)getAccountReceiptSortByAccountReceiptID:(NSMutableArray *)accountReceiptList
{
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"_accountReceiptID" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1, nil];
    NSArray *sortArray = [accountReceiptList sortedArrayUsingDescriptors:sortDescriptors];
    accountReceiptList = [sortArray mutableCopy];
    return accountReceiptList;
}
@end
