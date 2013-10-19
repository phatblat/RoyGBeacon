//
//  RGBFlipsideViewController.m
//  RoyGBeacon
//
//  Created by Ben Chatelain on 10/18/13.
//  Copyright (c) 2013 Ben Chatelain. All rights reserved.
//

#import "RGBFlipsideViewController.h"

@interface RGBFlipsideViewController ()

@end

@implementation RGBFlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
