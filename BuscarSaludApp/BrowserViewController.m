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
#import "FirstTableViewCell.h"
#import "UIView+AutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MPColorTools.h"


static NSString *CellIdentifier = @"CellIdentifier";
static NSString *LoadingCellIdentifier = @"LoadingCellIdentifier";
static NSString *FirstCellIdentifier = @"FirstCell";

#define kNavBarDefaultPosition CGPointMake(160,22)

@interface BrowserViewController ()

@property (nonatomic, assign) BOOL deleteRow;

@end

@implementation BrowserViewController{
    CLLocationManager *locationManager;
    double lat;
    double lon;
    NSMutableArray *doctorsList;
    CALayer *navbarLayer;
    BOOL nextPage;
    BOOL isInsertingRow;
    BOOL initApp;
    int lastIndexPathRow;
    int pageNumber;
    UILabel *navTitleLabel;

}

@synthesize latitude, longitude, tableTopConstraint, tableBottomContstraint, searchButton, doctorsButton;

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
    
    initApp = YES;
    
    self.deleteRow = NO;
    navbarLayer = nil;
    navbarLayer = self.navigationController.navigationBar.layer;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:FirstCellIdentifier];
    
    doctorsList = [[NSMutableArray alloc]init];
    
    navTitleLabel = [[UILabel alloc]init];
    [navTitleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:23]];
    [navTitleLabel setText:@"Directorio Médico"];
    navTitleLabel.backgroundColor = [UIColor clearColor];
    navTitleLabel.textColor = [UIColor whiteColor];
    navTitleLabel.frame = CGRectZero;
    self.navigationItem.titleView = navTitleLabel;
    [navTitleLabel sizeToFit];
    
    
    
    // Get location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];

    // Remove table cell separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    pageNumber = 1;
    
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
    if (nextPage) {
        NSString *pageNumberStringValue = [NSString stringWithFormat:@"%d", pageNumber];
        [postParams setValue:pageNumberStringValue forKey:@"pagina"];
    }

    //Makes the request
    [ApplicationDelegate.infoEngine getDoctorsList:postParams completionHandler:^(NSMutableArray *docsList){
        //When the list is null means: No doctors on the list.
        if ([doctorsList isKindOfClass:[NSNull class]]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                            message:@"No hay doctores en esta region"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Cancelar"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            initApp = NO;
            if (nextPage) {
                NSLog(@"aqui valor de docsList = %@", docsList);
                NSMutableArray *tempDoctors = [doctorsList mutableCopy];
                NSMutableArray *newDoctors = [docsList mutableCopy];
                doctorsList = [[NSMutableArray alloc]init];
                [doctorsList addObjectsFromArray:tempDoctors];
                [doctorsList addObjectsFromArray:newDoctors];
                
                /*for (NSMutableArray *doctors in tempDoctors){
                    [doctorsList addObject:doctors];
                }*/
                NSLog(@"New list count = %lu", (unsigned long)[doctorsList count]);
                NSLog(@"New full list of doctors = %@", doctorsList);
                isInsertingRow = YES;
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:lastIndexPathRow inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
                isInsertingRow = NO;
            }else{
                doctorsList = docsList;
                
                [self.tableView reloadData];
            }
            
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
    int count;
    if (self.deleteRow) {
        count = [doctorsList count];
    } else{
        count = [doctorsList count] + 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {        
        FirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier];
        NSLog(@"Cell for row at index path Primera celda!");
        lastIndexPathRow = indexPath.row;
        
        firstCell.nameLabel.text = @"Directorio Médico";
        [firstCell.iconContainer setImage:[UIImage imageNamed:@"firstCellIcon.png"]];
        
        [firstCell updateFonts];
        
        [firstCell setNeedsUpdateConstraints];
        [firstCell updateConstraintsIfNeeded];
        
        return firstCell;
    }else{
        if (indexPath.row == [doctorsList count]) {
            UITableViewCell *lastCell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
            NSLog(@"Ultima celda!");
            lastIndexPathRow = indexPath.row;
            
            return lastCell;

        }else{
            TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            //NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row];
                        
            
            NSString *nameText = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"nombre"];
            NSMutableAttributedString *nameAttributedText = [[NSMutableAttributedString alloc] initWithString:nameText];
            NSMutableParagraphStyle *nameParagraphStyle = [[NSMutableParagraphStyle alloc] init];
            [nameParagraphStyle setLineSpacing:0.0f];
            [nameAttributedText addAttribute:NSParagraphStyleAttributeName value:nameParagraphStyle range:NSMakeRange(0, nameText.length)];
            cell.nameLabel.attributedText = nameAttributedText;
            
            NSString *summaryText = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"extracto"];
            if ([summaryText isEqualToString:@""]) {
                //NSLog(@"Summarey empty");
                cell.summaryLabel.text = summaryText;
            }else{
                //NSLog(@"Summarey = %@", summaryText);
                NSMutableAttributedString *sumarryAttributedText = [[NSMutableAttributedString alloc] initWithString:summaryText];
                NSMutableParagraphStyle *summaryParagraphStyle = [[NSMutableParagraphStyle alloc] init];
                [summaryParagraphStyle setLineSpacing:0.0f];
                [sumarryAttributedText addAttribute:NSParagraphStyleAttributeName value:summaryParagraphStyle range:NSMakeRange(0, summaryText.length)];
                cell.summaryLabel.attributedText = sumarryAttributedText;
            }
            
            cell.phonelabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"telefono"];
            
            cell.streetLabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"calle"];
            
            cell.coloniaLabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"colonia"];
            
            
            if ([[[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
                [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
            }else{
                NSString *photo = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"img"];
                [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            }
            
            NSString *pointsText = [NSString stringWithFormat:@"%@ puntos", [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"puntos"]];
            cell.pointsLabel.text = pointsText;

            cell.cityLabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"ciudad"];
        
            cell.titleLabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"titulo"];
        
            cell.schoolLabel.text = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"escuela"];
            
        /*
            
            */
            
            
            /* /////////////// NO
             cell.nameLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"nombre"];
             cell.phonelabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"telefono"];
             cell.streetLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"calle"];
             cell.coloniaLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"colonia"];
             cell.cityLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"ciudad"];
             cell.titleLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"titulo"];
             cell.schoolLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"escuela"];
             
             NSString *pointsText = [NSString stringWithFormat:@"%@ puntos", [[doctorsList objectForKey:doctor] objectForKey:@"puntos"]];
             cell.pointsLabel.text = pointsText;
             
             if ([[[doctorsList objectForKey:doctor] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
             [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
             }else{
             NSString *photo = [[doctorsList objectForKey:doctor] objectForKey:@"img"];
             [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
             }
             
             NSString *summaryText = [[doctorsList objectForKey:doctor] objectForKey:@"extracto"];
             /////////////////// NO
             */
            
            /*
            
            
            */
            
            
            
            
            [cell updateFonts];
            
            [cell setNeedsUpdateConstraints];
            [cell updateConstraintsIfNeeded];
            
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (initApp == NO) {
        if (indexPath.row == [doctorsList count] ) {
            
            CGFloat height = 50;
            
            return height;
        }else{
            if (indexPath.row == 0) {
                FirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier];
                firstCell.nameLabel.text = @"Directorio Médico";
                
                [firstCell setNeedsUpdateConstraints];
                [firstCell updateConstraintsIfNeeded];
                
                [firstCell setNeedsLayout];
                [firstCell layoutIfNeeded];
                
                CGFloat height = 62;
                
                return height;
            }else{
                TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                //NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row];
                
                NSString *nameText = [[doctorsList objectAtIndex:indexPath.row-1] objectForKey:@"nombre"];
                NSMutableAttributedString *nameAttributedText = [[NSMutableAttributedString alloc] initWithString:nameText];
                NSMutableParagraphStyle *nameParagraphStyle = [[NSMutableParagraphStyle alloc] init];
                [nameParagraphStyle setLineSpacing:0.0f];
                [nameAttributedText addAttribute:NSParagraphStyleAttributeName value:nameParagraphStyle range:NSMakeRange(0, nameText.length)];
                cell.nameLabel.attributedText = nameAttributedText;
                
                NSString *summaryText = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"extracto"];
                
                NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:summaryText];
                NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
                [bodyParagraphStyle setLineSpacing:0.0f];
                [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, summaryText.length)];
                cell.summaryLabel.attributedText = bodyAttributedText;
                
                cell.phonelabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"telefono"];
                
                cell.streetLabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"calle"];
                
                cell.coloniaLabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"colonia"];
                
                
                if ([[[doctorsList objectAtIndex:indexPath.row] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
                    [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
                }else{
                    NSString *photo = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"img"];
                    [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                }
                
                NSString *pointsText = [NSString stringWithFormat:@"%@ puntos", [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"puntos"]];
                cell.pointsLabel.text = pointsText;
              
                cell.cityLabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"ciudad"];
            
                cell.titleLabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"titulo"];
            
                cell.schoolLabel.text = [[doctorsList objectAtIndex:indexPath.row] objectForKey:@"escuela"];
            /*
             
                
             
                
                
                
             
                */
                
                
                
                [cell updateFonts];
                
                [cell setNeedsUpdateConstraints];
                [cell updateConstraintsIfNeeded];
                
                cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
                
                [cell setNeedsLayout];
                [cell layoutIfNeeded];
                
                CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
                
                height += 1;
                
                return height;
            }
        }
    }else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isInsertingRow) {
        // A constraint exception will be thrown if the estimated row height for an inserted row is greater
        // than the actual height for that row. In order to work around this, we return the actual height
        // for the the row when inserting into the table view.
        // See: https://github.com/caoimghgin/TableViewCellWithAutoLayout/issues/6
        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    } else {
        return 500.0f;
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 45 && scrollView.contentOffset.y > 0) {
        [self animateNavigationBar:scrollView.contentOffset.y];
    }
    if (scrollView.contentOffset.y <= 0) {
        navbarLayer.position = CGPointMake(navbarLayer.position.x, self.navigationController.navigationBar.frame.size.height - 2);
        [self animateNavigationBar:0];
        /*[[self tableTopConstraint] setConstant:0];
        [UIView animateWithDuration:0.0 animations:^{
            [[self tableView] layoutIfNeeded];
        }];*/
    }
    if (scrollView.contentOffset.y > 64) {
        navbarLayer.position = CGPointMake(navbarLayer.position.x, -3);
        [self animateNavigationBar:45];
    }
}

- (void)animateNavigationBar:(CGFloat)offSet
{
    float transparency;
    transparency = (45-offSet)/45;
    CGFloat transValue = transparency;
    
    doctorsButton.alpha = transValue;
    searchButton.alpha = transValue;
    navTitleLabel.alpha = transValue;
    
    [UIView animateWithDuration:0.0 animations:^{
        navbarLayer.position =CGPointMake(navbarLayer.position.x, self.navigationController.navigationBar.frame.size.height - offSet - 2);
        [[self tableTopConstraint] setConstant:-offSet-2];
        [UIView animateWithDuration:0.0 animations:^{
            [[self tableView] layoutIfNeeded];
        }];

    }];
}

- (IBAction)loadMoreResults:(id)sender {
    
    nextPage = YES;
    ++pageNumber;
    [self getLocations:[latitude stringValue] andLongitude:[longitude stringValue]];
    
}
@end
