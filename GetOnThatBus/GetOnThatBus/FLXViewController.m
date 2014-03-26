//
//  FLXViewController.m
//  GetOnThatBus
//
//  Created by Wes Benwick on 3/25/14.
//  Copyright (c) 2014 FileLogix. All rights reserved.
//

#import "FLXViewController.h"
#import <MapKit/MapKit.h>

@interface FLXViewController () <MKMapViewDelegate> {
    
    __weak IBOutlet UIView *mapView;
}

@end

@implementation FLXViewController

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

@end
