//
//  BACameraPickerHandler.h
//  BACameraOverlay
//
//  Created by Jonathan Mateos on 30/9/16.
//  Copyright © 2016 Blonderful Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - BACameraPickerHandlerDelegate
@protocol BACameraPickerHandlerDelegate <NSObject>

- (void)cameraPickerHandlerDidTakePicture:(UIImage *)image;

@end


#pragma mark - Interface
@interface BACameraPickerHandler : NSObject <UINavigationControllerDelegate, UIPickerViewDelegate>

- (instancetype)init __unavailable;
- (instancetype)initWithDelegate:(id<BACameraPickerHandlerDelegate>)delegate;

- (void)showPickerInUIViewController:(UIViewController *)viewController;

@end
