//
//  BACameraPickerOverlayViewController.m
//  BACameraOverlay
//
//  Created by Jonathan Mateos on 30/9/16.
//  Copyright © 2016 Blonderful Apps. All rights reserved.
//

#import "BACameraPickerOverlayViewController.h"

#pragma mark - Constants
#define kTopSpace                   29.0
#define kNotificationCaptureItem    @"_UIImagePickerControllerUserDidCaptureItem"


#pragma mark - Interface
@interface BACameraPickerOverlayViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overlayDistanceLayoutConstraint;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) id <BACameraPickerOverlayViewControllerDelegate>delegate;

@end


#pragma mark - Implementation
@implementation BACameraPickerOverlayViewController

- (instancetype)initWithDelegate:(id<BACameraPickerOverlayViewControllerDelegate>)delegate {
    self = [super init];
    
    if (self) {
        _delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePickerNotification:) name:kNotificationCaptureItem object:nil];
    
    self.imageView.image = [self avatarImage];
}

- (UIImage *)avatarImage {
    
    return [UIImage imageNamed:@"image_overlay"];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceivePickerNotification:(NSNotification *)notification {
    
    if ([[notification name] isEqualToString:kNotificationCaptureItem]) {
        UIImage *avatarImage = [self captureAvatar];
        
        if ([self.delegate respondsToSelector:@selector(cameraPickerOverlayDidCaptureAvatar:)]) {
            [self.delegate cameraPickerOverlayDidCaptureAvatar:avatarImage];
        }
    }
}


#pragma mark - Image rendering
- (UIImage *)captureAvatar {
    
    // Update Avatar Image
    UIImage *avatarImage = [self avatarImage];
    UIImage *flippedAvatar = [UIImage imageWithCGImage:avatarImage.CGImage scale:avatarImage.scale orientation:UIImageOrientationUpMirrored];
    self.imageView.image = flippedAvatar;
    [self.overlayDistanceLayoutConstraint setConstant:-kTopSpace];
    [self.view needsUpdateConstraints];
    
    // Capture Image
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, - self.imageView.frame.origin.y - kTopSpace);
    [keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Update Captured Image
    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
    
    return image;
}

@end
