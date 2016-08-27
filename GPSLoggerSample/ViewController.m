//
//  ViewController.m
//  GPSLoggerSample
//
//  Created by WatanabeYoichiro on 2016/02/28.
//  Copyright © 2016年 YoichiroWatanabe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    [self.locationManager requestAlwaysAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        NSLog(@"%s", "Getting Location is Allowed.");
        // 5分ごとに繰り返しgetGpsDataを実行するようにタイマーを設定
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getGpsDataScheduled:)userInfo:nil repeats:YES];

    } else  {
        NSLog(@"%s", "Getting Location is not Allowed.");
    }

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"%f, %f", location.coordinate.latitude, location.coordinate.longitude);
}

- (void)getGpsDataScheduled:(NSTimer *)theTimer {
    CLLocation *location = [self.locationManager location];
    NSString *lat = [[NSString alloc] initWithFormat:@"%f", location.coordinate.latitude];  // 経度を取得
    NSString *lng = [[NSString alloc] initWithFormat:@"%f", location.coordinate.longitude]; // 緯度を取得
    NSLog(@"Timer: %@, %@", lat, lng);
}

@end
