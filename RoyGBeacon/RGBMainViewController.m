//
//  RGBMainViewController.m
//  RoyGBeacon
//
//  Created by Ben Chatelain on 10/18/13.
//  Copyright (c) 2013 Ben Chatelain. All rights reserved.
//

#import "RGBMainViewController.h"

@interface RGBMainViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *rangedRegions;
@property (strong, nonatomic) NSMutableDictionary *beacons;

@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end

@implementation RGBMainViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // This location manager will be used to notify the user of region state transitions.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;

    // Populate the regions we will range once.
    self.rangedRegions = [NSMutableArray array];

    NSArray * supportedProximityUUIDs = @[[[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"],
                                          [[NSUUID alloc] initWithUUIDString:@"5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"],
                                          [[NSUUID alloc] initWithUUIDString:@"74278BDA-B644-4520-8F0C-720EAF059935"],
                                          [[NSUUID alloc] initWithUUIDString:@"7D65B622-4AA8-4560-914C-502BE940BC16"]];

    [supportedProximityUUIDs enumerateObjectsUsingBlock:^(id uuidObj, NSUInteger uuidIdx, BOOL *uuidStop) {
        NSUUID *uuid = (NSUUID *)uuidObj;
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:[uuid UUIDString]];
        [self.rangedRegions addObject:region];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Start ranging when the view appears.
    [self.rangedRegions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLBeaconRegion *region = obj;
        [self.locationManager startRangingBeaconsInRegion:region];
    }];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if ([beacons count] > 0) {
        CLBeacon *nearestBeacon = [beacons firstObject];
        [self beaconDetected:nearestBeacon];
    }
}

#pragma mark - Beacon Handling

- (void)beaconDetected:(CLBeacon *)beacon
{
    self.uuidLabel.text = [beacon.proximityUUID UUIDString];
    self.majorLabel.text = [beacon.major stringValue];
    self.minorLabel.text = [beacon.minor stringValue];
    self.proximityLabel.text = [self stringWithProximity:beacon.proximity];
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
    self.rssiLabel.text = [NSString stringWithFormat:@"%ld", (long)beacon.rssi];
    [self setBackgroundColor:beacon.rssi];
}

- (NSString *)stringWithProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityImmediate:
            return @"Immediate";
            break;

        case CLProximityNear:
            return @"Near";
            break;

        case CLProximityFar:
            return @"Far";
            break;

        case CLProximityUnknown:
            return @"Unknown";
            break;

        default:
            return nil;
            break;
    }
}

- (void)setBackgroundColor:(NSInteger)signalStrength
{
    if (signalStrength < -90) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    } else if (signalStrength < -80) {
        self.view.backgroundColor = [UIColor purpleColor];
    } else if (signalStrength < -70) {
        self.view.backgroundColor = [UIColor blueColor];
    } else if (signalStrength < -60) {
        self.view.backgroundColor = [UIColor greenColor];
    } else if (signalStrength < -50) {
        self.view.backgroundColor = [UIColor yellowColor];
    } else if (signalStrength < -40) {
        self.view.backgroundColor = [UIColor orangeColor];
    } else if (signalStrength < -30) {
        self.view.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(RGBFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

@end
