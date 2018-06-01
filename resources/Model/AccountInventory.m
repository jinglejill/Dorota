//
//  AccountInventory.m
//  SAIM_TEST
//
//  Created by Thidaporn Kijkamjai on 2/2/2560 BE.
//  Copyright © 2560 Thidaporn Kijkamjai. All rights reserved.
//

#import "AccountInventory.h"

@implementation AccountInventory

- (AccountInventory *)initWithAccountInventoryID:(NSInteger)accountInventoryID productNameID:(NSInteger)productNameID quantity:(float)quantity status:(NSInteger)status inOutDate:(NSString *)inOutDate runningAccountReceiptHistory:(NSInteger)runningAccountReceiptHistory modifiedDate:(NSString *)modifiedDate
{
    self = [super init];
    if(self)
    {
        self.accountInventoryID = accountInventoryID;
        self.productNameID = productNameID;
        self.quantity = quantity;
        self.status = status;
        self.inOutDate = inOutDate;
        self.runningAccountReceiptHistory = runningAccountReceiptHistory;
        self.modifiedDate = modifiedDate;
    }
    
    return self;
}

+ (NSMutableArray *)getAccountInventorySortedByUsed:(NSMutableArray *)accountInventoryList
{
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"_productName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"_inOutDate" ascending:NO];
    NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"_used" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2,sortDescriptor3, nil];
    
    NSArray *sortArray = [accountInventoryList sortedArrayUsingDescriptors:sortDescriptors];
    accountInventoryList = [sortArray mutableCopy];
    return accountInventoryList;
}
@end
