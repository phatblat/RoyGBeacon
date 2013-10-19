//
//  RGBFlipsideViewController.h
//  RoyGBeacon
//
//  Created by Ben Chatelain on 10/18/13.
//  Copyright (c) 2013 Ben Chatelain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RGBFlipsideViewController;

@protocol RGBFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RGBFlipsideViewController *)controller;
@end

@interface RGBFlipsideViewController : UIViewController

@property (weak, nonatomic) id <RGBFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
