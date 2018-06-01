//
//  GenerateQRCodePageViewController.h
//  SAIM_TEST
//
//  Created by Thidaporn Kijkamjai on 9/2/2559 BE.
//  Copyright © 2559 Thidaporn Kijkamjai. All rights reserved.
//

//#import "ViewController.h"
#import "HomeModel.h"


@interface GenerateQRCodePageViewController : UIViewController
<UIPageViewControllerDataSource,HomeModelProtocol,UIScrollViewDelegate,UIPageViewControllerDelegate>
- (IBAction)backButtonClicked:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageController;
- (IBAction)generateQRCode:(id)sender;
- (IBAction)unwindToGenerateQRCodePage:(UIStoryboardSegue *)segue;
@end
