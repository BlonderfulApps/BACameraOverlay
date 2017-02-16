//
//  HomeViewController.m
//  BACameraOverlay
//
//  Created by Jonathan Mateos on 30/9/16.
//  Copyright © 2016 Blonderful Apps. All rights reserved.
//

#import "HomeViewController.h"
#import "BACameraPickerHandler.h"

@interface HomeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, BACameraPickerHandlerDelegate>

@property (strong, nonatomic) BACameraPickerHandler *cameraPickerHandler;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.cameraPickerHandler = [[BACameraPickerHandler alloc] initWithDelegate:self];
        [self.cameraPickerHandler showPickerInUIViewController:self];
    } else {
        NSLog(@"No camera - test with real device");
    }
}

#pragma mark BACameraPickerHandlerDelegate
- (void)cameraPickerHandlerDidTakePicture:(UIImage *)image {
    [self.imageView setImage:image];
}

@end
