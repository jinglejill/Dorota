//
//  UserMenuViewController.m
//  SaleAndInventoryManagement
//
//  Created by Thidaporn Kijkamjai on 7/23/2558 BE.
//  Copyright (c) 2558 Thidaporn Kijkamjai. All rights reserved.
//

#import "UserMenuViewController.h"
#import "GenerateQRCodePageViewController.h"
#import "Utility.h"
#import "Product.h"
#import "ReceiptViewController.h"
#import "CustomerReceipt.h"
#import "SharedCustomerReceipt.h"
#import "SharedSelectedEvent.h"
#import "ProductPostViewController.h"
#import "ProductPostedViewController.h"
#import "SharedReceiptItem.h"
#import "SharedReceipt.h"
#import "SharedProduct.h"
#import "PushSync.h"
#import "SharedPushSync.h"


enum enumAdminMenu
{
    menuEventInventorySummary,
    menuEventInventoryItem,
    menuSalesScan,
    menuSalesCustomMade,
    menuSalesPreOrder,
    menuReceiptSummary    
};

@interface UserMenuViewController ()
{
    HomeModel *_homeModel;
    UIActivityIndicatorView *indicator;
    UIView *overlayView;
    NSString *_SMSReceiptID;
    NSArray *_menuWithSales;
    NSArray *_menuWithoutSales;
    NSArray *_menuExtra;
    Event *_event;
}

@end

@implementation UserMenuViewController
@synthesize menuExtra;


- (IBAction)unwindToUserMenu:(UIStoryboardSegue *)segue {
    
}

- (void)itemsUpdated
{
    
}

- (void)loadView
{
    [super loadView];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    _homeModel.delegate = self;
    
    {
        overlayView = [[UIView alloc] initWithFrame:self.view.frame];
        overlayView.backgroundColor = [UIColor colorWithRed:256 green:256 blue:256 alpha:0];
        
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.frame = CGRectMake(self.view.bounds.size.width/2-indicator.frame.size.width/2,self.view.bounds.size.height/2-indicator.frame.size.height/2,indicator.frame.size.width,indicator.frame.size.height);
    }
    
    
    _event = [Event getSelectedEvent];
    self.navigationController.toolbarHidden = YES;
    
    _menuWithSales = @[@"Event inventory summary",
                       @"Event inventory item",                       
                       @"Sales scan",
                       @"Sales custom-made",
                       @"Sales pre-order",
                       @"Receipt summary"
                       ];
    _menuWithoutSales = @[@"Event inventory summary",
                          @"Event inventory item",
                          @"Receipt summary"
                          ];
    _menuExtra = @[@"To post product",
                   @"Posted product",
                   @"Create QR Code File"];

    
    
    [self loadViewProcess];
}

- (void)loadViewProcess
{
    if(![Utility hasEventSales:_event.eventID])
    {
        [self loadingOverlayView];
        [_homeModel downloadItems:dbSalesSummary condition:_event];
    }
}

- (void)itemsDownloaded:(NSArray *)items
{
    [self removeOverlayViews];
    [Utility setEventSales:@"1" eventID:_event.eventID];
    
    int i=0;
    [[SharedProduct sharedProduct].productList addObjectsFromArray:items[i++]];
    [[SharedReceipt sharedReceipt].receiptList addObjectsFromArray:items[i++]];
    [[SharedReceiptItem sharedReceiptItem].receiptItemList addObjectsFromArray:items[i++]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (BOOL)isCurrentPeriod
{
    Event *event = [Event getSelectedEvent];
 
    
    //prepare event date for segment control
    NSDate *datePeriodTo = [Utility stringToDate:event.periodTo fromFormat:[Utility setting:vFormatDateDB]];
    NSDate *datePeriodFrom = [Utility stringToDate:event.periodFrom fromFormat:[Utility setting:vFormatDateDB]];
    
    NSInteger numberOfDays = [Utility numberOfDaysFromDate:datePeriodFrom dateTo:datePeriodTo];
    NSDate *dateNow = [Utility GMTDate:[Utility dateFromDateTime:[NSDate date]]];
    
    
    //prepare array for segment control and selectedDate
    BOOL isCurrentPeriod = NO;
    int daysToAdd = 0;
    for(int i = 0; i<numberOfDays; i++)
    {
        daysToAdd = i;
        NSDate *newDate1 = [datePeriodFrom dateByAddingTimeInterval:60*60*24*daysToAdd];
        
        //show detail for current date
        if([newDate1 isEqualToDate:dateNow]){
            isCurrentPeriod = YES;
        }
    }
    return isCurrentPeriod;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(menuExtra)
    {
        return [_menuExtra count];
    }
    else
    {
        return [self isCurrentPeriod]?[_menuWithSales count]:[_menuWithoutSales count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger item = indexPath.item;
    
    static NSString *CellIdentifier = @"reuseIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if(menuExtra)
    {
        cell.textLabel.text = _menuExtra[item];
    }
    else
    {
        cell.textLabel.text = [self isCurrentPeriod]?_menuWithSales[item]:_menuWithoutSales[item];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(menuExtra)
    {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"segProductPost" sender:self];
                break;
            case 1:
                [self performSegueWithIdentifier:@"segProductPosted" sender:self];
                break;
            case 2:
                [self performSegueWithIdentifier:@"segGenerateQRCodePage" sender:self];
                break;
        }
    }
    else
    {
        if([self isCurrentPeriod])
        {
            switch (indexPath.row) {
                case menuEventInventorySummary:
                    [self performSegueWithIdentifier:@"segEventInventorySummaryPage" sender:self];
                    break;
                case menuEventInventoryItem:
                    [self performSegueWithIdentifier:@"segEventInventoryItemUserPage" sender:self];
                    break;
                case menuSalesScan:
                {
                    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
                    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                    [self performSegueWithIdentifier:@"segSalesScan" sender:self];
                }
                    break;
                case menuSalesCustomMade:
                    [self performSegueWithIdentifier:@"segSalesCustomMade" sender:self];
                    break;
                case menuSalesPreOrder:
                    [self performSegueWithIdentifier:@"segPreOrderPage" sender:self];
                    break;
                case menuReceiptSummary:
                {
                    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
                    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                    [self performSegueWithIdentifier:@"segReceiptSummaryFromUserMenu" sender:self];
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            switch (indexPath.row) {
                case 0:
                    [self performSegueWithIdentifier:@"segEventInventorySummaryPage" sender:self];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"segEventInventoryItemUserPage" sender:self];
                    break;
                case 2:
                {
                    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
                    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
                    [self performSegueWithIdentifier:@"segReceiptSummaryFromUserMenu" sender:self];
                }
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"segProductPost"])
    {
        
    }
    else if([[segue identifier] isEqualToString:@"segProductPosted"])
    {
        ProductPostedViewController *vc = [segue destinationViewController];
        vc.fromUserMenu = YES;
    }
    else if([[segue identifier] isEqualToString:@"segGenerateQRCodePage"])
    {
        GenerateQRCodePageViewController *vc = [segue destinationViewController];
        vc.fromUserMenu = YES;
    }
}

-(void) loadingOverlayView
{
    [indicator startAnimating];
    indicator.layer.zPosition = 1;
    indicator.alpha = 1;
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    
    // and just add them to navigationbar view
    [self.navigationController.view addSubview:overlayView];
    [self.navigationController.view addSubview:indicator];
}

-(void) removeOverlayViews{
    UIView *view = overlayView;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         view.alpha = 0.0;
                         indicator.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         dispatch_async(dispatch_get_main_queue(),^ {
                             [view removeFromSuperview];
                             [indicator stopAnimating];
                             [indicator removeFromSuperview];
                         } );
                     }
     ];
     [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void) connectionFail
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:[Utility subjectNoConnection]
                                                                   message:[Utility detailNoConnection]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //                                                              exit(0);
                                                          }];
    
    [alert addAction:defaultAction];
    dispatch_async(dispatch_get_main_queue(),^ {
        [self presentViewController:alert animated:YES completion:nil];
    } );
}

@end
