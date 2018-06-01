//
//  CustomPrintPageRenderer.h
//  testPdf
//
//  Created by Thidaporn Kijkamjai on 1/27/2560 BE.
//  Copyright © 2560 Appxelent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPrintPageRenderer : UIPrintPageRenderer
@property (nonatomic) CGFloat A4PageWidth;
@property (nonatomic) CGFloat A4PageHeight;

- (id)init;
- (NSString *)exportHTMLContentToPDF:(NSMutableArray *)htmlContentList fileName:(NSString *)fileName;
@end