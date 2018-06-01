//
//  QRCodeView.h
//  SAIM_UPDATING
//
//  Created by Thidaporn Kijkamjai on 7/10/2559 BE.
//  Copyright © 2559 Thidaporn Kijkamjai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeView : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgVwQRCode;
@property (strong, nonatomic) UIView *vwPrint;

@property (strong, nonatomic) IBOutlet UILabel *lblProductName;
@property (strong, nonatomic) IBOutlet UILabel *lblColor;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@end
