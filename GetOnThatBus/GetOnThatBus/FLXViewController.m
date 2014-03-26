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
    
    __weak IBOutlet MKMapView *mapView;
    __weak IBOutlet UIView *myView;
}

@end

@implementation FLXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(32.13121, -81.17391);
    
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(1.0, 1.0);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
    
    mapView.region = region;
    
    MKPointAnnotation  *annotation = [MKPointAnnotation new];
    
    annotation.coordinate = centerCoordinate;
    annotation.title = @"My spot";
    
    mapView.layer.shadowColor = [[UIColor blackColor] CGColor];
    mapView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
    mapView.layer.shadowOpacity = 1.0f;
    mapView.layer.shadowRadius = 10.0f;
    
    [mapView showsUserLocation];
    
    [mapView addAnnotation:annotation];
    
    CLGeocoder* geocoder = [CLGeocoder new];
    
    
    [geocoder geocodeAddressString:@"Everbank Field" completionHandler:^(NSArray *placemarks, NSError *error)
        {
        
            for (CLPlacemark* place in placemarks) {
                MKPointAnnotation* annotation = [MKPointAnnotation new];
                annotation.coordinate = place.location.coordinate;
                [mapView addAnnotation:annotation];
            }
        }
     
     ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touched %@", [mapView userLocation]);
    
}

-(MKAnnotationView *)mapView:(MKMapView *)myMapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    if (annotation == myMapView.userLocation) {
        return nil;
    }
    
    MKPinAnnotationView* pin = [[MKPinAnnotationView alloc]  initWithAnnotation:annotation reuseIdentifier:nil];
    pin.image = [UIImage imageNamed:@"FileLogix"];
    pin.frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
    
    pin.animatesDrop = YES;
    
    [pin sizeToFit];
    
    pin.canShowCallout = YES;
    
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pin;
}

-(void)mapView:(MKMapView *)myMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"Tapped");
    
}



@end
