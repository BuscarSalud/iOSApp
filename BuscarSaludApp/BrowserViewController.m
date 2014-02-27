//
//  BrowserViewController.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 2/20/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "BrowserViewController.h"
#import "AppDelegate.h"
#import "TableViewCell.h"
#import "UIView+AutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *CellIdentifier = @"CellIdentifier";

#define kNavBarDefaultPosition CGPointMake(160,22)

@interface BrowserViewController ()

@end

@implementation BrowserViewController{
    CLLocationManager *locationManager;
    double lat;
    double lon;
    NSDictionary *doctorsList;

}

@synthesize latitude, longitude;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    // Get location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    // Remove table cell separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self animateNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

#pragma mark - Get Current Location
//If something went wrong when getting the device exact location.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"No pudimos encontrar tu ubicación, la aplicación necesita saber tu ubicacion exacta."
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //Gets the current location of the device.
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    //If the result is not null, then we have a valid location.
    if (currentLocation != nil) {
        lon = currentLocation.coordinate.longitude;
        lat = currentLocation.coordinate.latitude;
    }
    
    // Stop Location Manager.
    [locationManager stopUpdatingLocation];
    
    //We convert the latitud and longitud into a number easier to manage.
    latitude = [NSNumber numberWithDouble:lat];
    longitude = [NSNumber numberWithDouble:lon];
    NSLog(@"Latitude: %@", latitude);
    NSLog(@"Longitude: %@", longitude);
    
    //After getting the location we call the method to go and fetch the doctors' result list.
    [self getLocations:[latitude stringValue] andLongitude:[longitude stringValue]];
    
}


#pragma mark - Get doctors' results
-(void)getLocations:(NSString *)latitudeUser andLongitude:(NSString *)longitudeUser
{
    //Will create parameters for the url request.
    NSMutableDictionary *postParams = [[NSMutableDictionary alloc]init];
    [postParams setValue:latitudeUser forKey:@"lat"];
    [postParams setValue:longitudeUser forKey:@"lon"];
    [postParams setValue:@"10" forKey:@"limite"];

    //Makes the request
    [ApplicationDelegate.infoEngine getDoctorsList:postParams completionHandler:^(NSDictionary *docsList){
        //When the list is null means: No doctors on the list.
        if ([doctorsList isKindOfClass:[NSNull class]]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                            message:@"No hay doctores en esta region"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancelar"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            doctorsList = docsList;
            [self.tableView reloadData];
            NSLog(@"%@", doctorsList);
            NSLog(@"Count doctors: %d", [doctorsList count]);
        }
    }errorHandler:^(NSError *error) {
        //Handling an error in the url request.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                        message:@"Ha ocurrido un error, vuelve a intentarlo"
                                                       delegate:nil
                                              cancelButtonTitle:@"Aceptar"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [doctorsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row];
    
    [cell updateFonts];
    
    cell.nameLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"nombre"];
    cell.phonelabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"telefono"];
    cell.streetLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"calle"];
    cell.coloniaLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"colonia"];
    cell.cityLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"ciudad"];
    cell.titleLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"titulo"];
    cell.schoolLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"escuela"];
    
    if ([[[doctorsList objectForKey:doctor] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
        [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
    }else{
        NSString *photo = [[doctorsList objectForKey:doctor] objectForKey:@"img"];
        [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    NSString *summaryText = [[doctorsList objectForKey:doctor] objectForKey:@"extracto"];
    NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:summaryText];
    NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [bodyParagraphStyle setLineSpacing:0.0f];
    [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, summaryText.length)];
    cell.summaryLabel.attributedText = bodyAttributedText;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row];
    
    [cell updateFonts];
    
    cell.nameLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"nombre"];
    cell.phonelabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"telefono"];
    cell.streetLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"calle"];
    cell.coloniaLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"colonia"];
    cell.cityLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"ciudad"];
    cell.titleLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"titulo"];
    cell.schoolLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"escuela"];
    
    NSString *summaryText = [[doctorsList objectForKey:doctor] objectForKey:@"extracto"];
    NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:summaryText];
    NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    [bodyParagraphStyle setLineSpacing:0.0f];
    [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, summaryText.length)];
    cell.summaryLabel.attributedText = bodyAttributedText;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    height += 1;
    
    return height;
}




- (void)animateNavigationBar
{
    CALayer *navbarLayer = nil;
    navbarLayer = self.navigationController.navigationBar.layer;
    [UIView animateWithDuration:2 animations:^{
        navbarLayer.position = CGPointMake(navbarLayer.position.x,
                                     -self.navigationController.navigationBar.frame.
                                           size.height);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1 animations:^{
            navbarLayer.position = CGPointMake(navbarLayer.position.x,
                                               + self.navigationController.navigationBar.frame.
                                               size.height);
        }];
    }];
}

@end
