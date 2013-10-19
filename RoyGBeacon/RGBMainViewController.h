//
//  RGBMainViewController.h
//  RoyGBeacon
//
//  Created by Ben Chatelain on 10/18/13.
//  Copyright (c) 2013 Ben Chatelain. All rights reserved.
//

#import "RGBFlipsideViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RGBMainViewController : UIViewController <RGBFlipsideViewControllerDelegate, UIPopoverControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
