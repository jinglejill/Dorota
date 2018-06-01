//
//  EventInventorySummaryPageViewController.h
//  SAIM_UPDATING
//
//  Created by Thidaporn Kijkamjai on 4/10/2559 BE.
//  Copyright © 2559 Thidaporn Kijkamjai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventInventorySummaryPageViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnAllOrRemaining;
- (IBAction)allOrRemaining:(id)sender;
- (IBAction)compareInventory:(id)sender;


@end
