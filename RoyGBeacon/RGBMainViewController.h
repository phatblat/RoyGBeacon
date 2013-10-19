//
//  RGBMainViewController.h
//  RoyGBeacon
//
//  Created by Ben Chatelain on 10/18/13.
//  Copyright (c) 2013 Ben Chatelain. All rights reserved.
//

#import "RGBFlipsideViewController.h"

@interface RGBMainViewController : UIViewController <RGBFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
