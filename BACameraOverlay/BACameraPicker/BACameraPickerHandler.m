//
//  BACameraPickerHandler.m
//  BACameraOverlay
//
//  Created by Jonathan Mateos on 30/9/16.
//  Copyright © 2016 Blonderful Apps. All rights reserved.
//

#import "BACameraPickerHandler.h"

#import "BACameraPickerOverlayViewController.h"


#pragma mark - Interface
@interface BACameraPickerHandler () <BACameraPickerOverlayViewControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) BACameraPickerOverlayViewController *cameraPickerOverlayViewController;
@property (weak, nonatomic) id <BACameraPickerHandlerDelegate> delegate;

@end


#pragma mark - Implementation
@implementation BACameraPickerHandler

- (instancetype)initWithDelegate:(id<BACameraPickerHandlerDelegate>)delegate {
    self = [super init];
    
    if (self) {
        _delegate = delegate;
    }
    
    return self;
}

- (void)showPickerInUIViewController:(UIViewController *)viewController {
    
    [self createImagePicker];
    [self createOverlay];
    
    [viewController presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (void)createImagePicker {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    self.imagePickerController.showsCameraControls = YES;
    self.imagePickerController.navigationBarHidden = YES;
    self.imagePickerController.toolbarHidden = YES;
    self.imagePickerController.allowsEditing = NO;
}

- (void)createOverlay {
    self.cameraPickerOverlayViewController = [[BACameraPickerOverlayViewController alloc] initWithDelegate:self];
    [self.cameraPickerOverlayViewController.view setFrame:self.imagePickerController.view.frame];
    self.imagePickerController.cameraOverlayView = self.cameraPickerOverlayViewController.view;    
}


#pragma mark - CACameraPickerOverlayViewControllerDelegate
- (void)cameraPickerOverlayDidCaptureAvatar:(UIImage *)image {
    if ([self.delegate respondsToSelector:@selector(cameraPickerHandlerDidTakePicture:)]) {
        [self.delegate cameraPickerHandlerDidTakePicture:image];
    }
    
    [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

@end
