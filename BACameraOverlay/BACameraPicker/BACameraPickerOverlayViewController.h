//
//  BACameraPickerOverlayViewController.h
//  BACameraOverlay
//
//  Created by Jonathan Mateos on 30/9/16.
//  Copyright © 2016 Blonderful Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - BACameraPickerOverlayViewControllerDelegate
@protocol BACameraPickerOverlayViewControllerDelegate <NSObject>

- (void)cameraPickerOverlayDidCaptureAvatar:(UIImage *)image;

@end


#pragma mark - Interface
@interface BACameraPickerOverlayViewController : UIViewController

- (instancetype)init __unavailable;
- (instancetype)initWithDelegate:(id<BACameraPickerOverlayViewControllerDelegate>)delegate;

@end
