//
//  FLXViewController.m
//  GetOnThatBus
//
//  Created by Wes Benwick on 3/25/14.
//  Copyright (c) 2014 FileLogix. All rights reserved.
//

#import "FLXViewController.h"
#import "FLXBusStopViewController.h"
#import <MapKit/MapKit.h>

@interface FLXViewController () <MKMapViewDelegate> {
    
    __weak IBOutlet MKMapView *mapView;
    __weak IBOutlet UIView *myView;
    __weak NSDictionary *myBusStops;
}

@end

@implementation FLXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(41.88152, -87.666695);
    
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.29, 0.29);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
    
    mapView.region = region;
    
//    MKPointAnnotation  *annotation = [MKPointAnnotation new];
    
//    annotation.coordinate = centerCoordinate;
//    annotation.title = @"My spot";
    
//    [mapView showsUserLocation];
    
//    [mapView addAnnotation:annotation];
    
//    CLGeocoder* geocoder = [CLGeocoder new];
//    
//    
//    [geocoder geocodeAddressString:@"Chicago" completionHandler:^(NSArray *placemarks, NSError *error)
//        {
//        
//            for (CLPlacemark* place in placemarks) {
//                MKPointAnnotation* annotation = [MKPointAnnotation new];
//                annotation.coordinate = place.location.coordinate;
//                [mapView addAnnotation:annotation];
//            }
//        }
//     
//     ];
    
    NSURL* url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError* error;
        NSDictionary* myResults;
        myResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        myBusStops = myResults[@"row"];
        
        for (NSDictionary *busStop in myBusStops) {
            NSLog(@"Lat: %@ %@",busStop[@"latitude"], busStop[@"longitude"]);
            MKPointAnnotation  *annotation = [MKPointAnnotation new];
            annotation.coordinate = CLLocationCoordinate2DMake([busStop[@"latitude"] doubleValue],[busStop[@"longitude"] doubleValue]);
            annotation.title = busStop[@"cta_stop_name"];
            annotation.subtitle = busStop[@"routes"];
            
            [mapView addAnnotation:annotation];
        }
        
    }];
    
    [myBusStops ob]
    
}

-(void)viewDidAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:YES animated:YES];

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
//    FLXBusStopViewController *busStopViewController = [[FLXBusStopViewController alloc] init];
//    [self presentViewController:busStopViewController animated:YES completion:nil];
    [self performSegueWithIdentifier:@"BusStop" sender:control];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIControl*)sender {
    NSLog(@"Segue");
    FLXBusStopViewController *busStopViewController = [segue destinationViewController];
    busStopViewController.busStopName = @"Test";
    
// NEED TO SUBCLASS MKPOINTANNOTATION ADD CUSTOM DICTIONARY FIELD

}



@end
