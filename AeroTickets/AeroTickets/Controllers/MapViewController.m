//
//  MapViewController.m
//  AeroTickets
//
//  Created by Pavel Khlebnikov on 08.07.2021.
//

#import "MapViewController.h"
#import "LocationService.h"
#import "APIManager.h"
#import <MapKit/MapKit.h>
#import "DataManager.h"
#import "MapPrice.h"
#import <CoreLocation/CoreLocation.h>
#import "CoreDataHelper.h"

@interface MapViewController ()

@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Карта цен";
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    [_mapView setDelegate:self];
    [self.view addSubview:_mapView];
    
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dataLoadedSuccessfully {
    _locationService = [[LocationService alloc] init];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [_mapView setRegion: region animated: YES];
    
    if (currentLocation) {
        _origin = [[DataManager sharedInstance] cityForLocation:currentLocation];
        if (_origin) {
            [[APIManager sharedInstance] mapPricesFor:_origin withCompletion:^(NSArray *prices) {
                self.prices = prices;
            }];
        }
    }
}


- (void)setPrices:(NSArray *)prices {
    _prices = prices;
    [_mapView removeAnnotations: _mapView.annotations];
 
    for (MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
            annotation.coordinate = price.destination.coordinate;
            
            [self->_mapView addAnnotation: annotation];
        });
    }
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MarkerIdentifier";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        NSInteger AnnotationIndex = [_mapView.annotations indexOfObject:annotation];
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeContactAdd];
        button.tag = AnnotationIndex;
        [button addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
        
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5, 5);
        annotationView.rightCalloutAccessoryView = button;
    }
    annotationView.annotation = annotation;
    
    return annotationView;
}

- (void)placeButtonDidTap:(UIButton *)sender {
    NSString *city = [self.mapView.annotations[sender.tag] title];
    NSArray *arrayFromStringCity = [city componentsSeparatedByString:@"("];
    
    if (arrayFromStringCity.count == 2) {
        NSString *cityName = [arrayFromStringCity[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *cityCode = [arrayFromStringCity[1] stringByReplacingOccurrencesOfString:@")" withString:@""];
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"SELF.destination.name contains[cd]%@ and SELF.destination.code contains[cd]%@", cityName, cityCode];
        
        NSMutableArray *valuesPrices =  [NSMutableArray arrayWithArray:[self.prices filteredArrayUsingPredicate:filterPredicate]];
        [self addMapPriceToFavorite:valuesPrices];
    }
}

- (void) addMapPriceToFavorite:(NSArray *)prices {
    for (MapPrice *price in prices) {
        [[CoreDataHelper sharedInstance] addMapPriceToFavorite:price];
    }
}

@end
