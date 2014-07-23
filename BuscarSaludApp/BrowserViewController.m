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
#import "LoadingMoreTableViewCell.h"
#import "FiltersTableViewCell.h"
#import "UIView+AutoLayout.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MPColorTools.h"
#import "GRKGradientView.h"
#import "Specialty.h"
#import "State.h"
#import "StatesDictionary.h"
#import "CategoriesDictionary.h"



static NSString *CellIdentifier = @"CellIdentifier";
static NSString *LoadingCellIdentifier = @"LoadingCellIdentifier";
static NSString *FirstCellIdentifier = @"FirstCell";
static NSString *FiltersCellIdentifier = @"FiltersCellIdentifier";

#define kNavBarDefaultPosition CGPointMake(160,22)

@interface BrowserViewController ()

@property (nonatomic, assign) BOOL deleteRow;
@property (strong, nonatomic) IBOutlet UIView *searchContentView;
@property (strong, nonatomic) IBOutlet UIView *overlaySearchBackground;
@property (strong, nonatomic) IBOutlet UIView *searchBar;
@property (strong, nonatomic) IBOutlet UIView *filtersView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *showFilterOptionsButton;
@property (strong, nonatomic) IBOutlet GRKGradientView *gradientFilterSearchButton;
@property (strong, nonatomic) IBOutlet GRKGradientView *gradientFilterCancelButton;
@property (strong, nonatomic) IBOutlet GRKGradientView *selectFilterStateButton;
@property (strong, nonatomic) IBOutlet GRKGradientView *selectFilterCategoryButton;
@property (strong, nonatomic) IBOutlet UILabel *filtersButtonSearchLabel;
@property (strong, nonatomic) IBOutlet UILabel *filtersButtonCancelLabel;
@property (strong, nonatomic) IBOutlet UILabel *filtersButtonStateLabel;
@property (strong, nonatomic) IBOutlet UILabel *filtersButtonCategoryLabel;
@property (strong, nonatomic) IBOutlet UITableView *filtersTableView;
@property (strong, nonatomic) IBOutlet UITableView *filtersTableViewCategories;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorMain;

@property (nonatomic, strong) NSLayoutConstraint *topConstraintSearchBar;
@property (nonatomic, strong) NSLayoutConstraint *topConstraintTableView;
@property (nonatomic, strong) NSLayoutConstraint *topConstraintFiltersView;
@property (nonatomic, strong) NSLayoutConstraint *heighConstraintFiltersView;
@property (nonatomic, strong) NSLayoutConstraint *topViewConstraint;


@end

@implementation BrowserViewController{
  CLLocationManager *locationManager;
  double lat;
  double lon;
  NSMutableDictionary *doctorsList;
  NSMutableDictionary *paramsReadyToSearch;
  CALayer *navbarLayer;
  int lastIndexPathRow;
  int pageNumber;
  int filterOption;
  UILabel *navTitleLabel;
  AppDelegate *appdelgateobj;
  BOOL nextPage;
  BOOL isInsertingRow;
  BOOL initApp;
  BOOL search;
  BOOL filters;
  BOOL filtersOpen;
  BOOL onceCategory;
  BOOL onceState;
  BOOL newFilters;
  NSMutableArray *specialtiesObjectArray;
  NSMutableArray *statesObjectArray;
}

@synthesize latitude, longitude, tableTopConstraint, tableBottomContstraint, searchButton, doctorsButton, specialtiesDictionary, statesDictionary, doctorsStatic, previousSpecialtiesDictionary, previousStatesDictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self setupViews];
  initApp = YES;
  search = NO;
  filters = NO;
  filtersOpen = NO;
  onceCategory = YES;
  onceState = YES;
  newFilters = NO;
  
  self.tableView.alpha = 0.0;
  
  UIColor *backgroundColor = [UIColor colorWithRGB:0xd9dcd3];
  self.view.backgroundColor = backgroundColor;
  self.tableView.backgroundColor = backgroundColor;
  
  self.deleteRow = NO;
  navbarLayer = nil;
  navbarLayer = self.navigationController.navigationBar.layer;
  
  self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.filtersTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.filtersTableViewCategories.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
  [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:CellIdentifier];
  [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:FirstCellIdentifier];
  [self.tableView registerClass:[LoadingMoreTableViewCell class] forCellReuseIdentifier:LoadingCellIdentifier];
  [self.filtersTableView registerClass:[FiltersTableViewCell class] forCellReuseIdentifier:FiltersCellIdentifier];
  [self.filtersTableViewCategories registerClass:[FiltersTableViewCell class] forCellReuseIdentifier:FiltersCellIdentifier];
  
  doctorsList = [[NSMutableDictionary alloc]init];
  
  navTitleLabel = [[UILabel alloc]init];
  [navTitleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:23]];
  [navTitleLabel setText:@"Directorio Médico"];
  navTitleLabel.backgroundColor = [UIColor clearColor];
  navTitleLabel.textColor = [UIColor whiteColor];
  navTitleLabel.frame = CGRectZero;
  self.navigationItem.titleView = navTitleLabel;
  [navTitleLabel sizeToFit];
  
  self.activityIndicatorMain = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
  self.activityIndicatorMain.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:self.activityIndicatorMain];
  [self.activityIndicatorMain startAnimating];
  
  [self.view setNeedsUpdateConstraints];
  
  // Get location
  locationManager = [[CLLocationManager alloc] init];
  locationManager.delegate = self;
  locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  [locationManager startUpdatingLocation];
  
  // Remove table cell separator
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  pageNumber = 1;
  
  [self.showFilterOptionsButton addTarget: self
                                   action: @selector(showFilterOptionsMethod:)
                         forControlEvents: UIControlEventTouchDown];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self action:@selector(dismissSearch)];
  [self.searchContentView addGestureRecognizer:tap];
  
  State *stateReturned = [StatesDictionary returnState:@"24"];
  Specialty *categoryReturned = [CategoriesDictionary returnSpecialty:@"86"];
  
  NSLog(@"Estado numero 1 es igual a = %@", stateReturned.displayName);
  NSLog(@"Especialidad numero 107 es igual a = %@", categoryReturned.displayName);
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  //[self getStateMethod];
  //[self getSpecialtyMethod];
  
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
  //[self.tableView reloadData];
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
  [self getDoctorsFromLocation:[latitude stringValue] andLongitude:[longitude stringValue]];
  
}


#pragma mark - Make Requests to the Server
-(void)getDoctorsFromLocation:(NSString *)latitudeUser andLongitude:(NSString *)longitudeUser
{
  //Will create parameters for the url request.
  NSMutableDictionary *postParams = [[NSMutableDictionary alloc]init];
  [postParams setValue:@"1" forKey:@"opt"];
  [postParams setValue:@"distancia" forKey:@"orden"];
  [postParams setValue:latitudeUser forKey:@"latitud"];
  [postParams setValue:longitudeUser forKey:@"longitud"];
  [postParams setValue:@"10" forKey:@"limite"];
  [postParams setValue:@"693e099a65935c5f839fab1330c8d360" forKey:@"key"];
  
  
  //Makes the request
  search = NO;
  [self makeRequestLocation:postParams];
}

-(void)makeRequestLocation:(NSMutableDictionary *)params
{
  if (nextPage) {
    NSString *pageNumberStringValue = [NSString stringWithFormat:@"%d", pageNumber];
    [params setValue:pageNumberStringValue forKey:@"pagina"];
  }
  
  [ApplicationDelegate.infoEngine getDoctorsList:params completionHandler:^(NSDictionary *docsList){
    //When the list is null means: No doctors on the list.
    if ([docsList count] == 0) {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                      message:@"No hay doctores en esta region"
                                                     delegate:nil
                                            cancelButtonTitle:@"Cancelar"
                                            otherButtonTitles:nil];
      [alert show];
    }else{
      initApp = NO;
      if (nextPage) {
        //NSLog(@"aqui valor de docsList = %@", docsList);
        /*NSMutableArray *tempDoctors = [doctorsList mutableCopy];
         NSMutableArray *newDoctors = [docsList mutableCopy];
         doctorsList = [[NSMutableArray alloc]init];
         [doctorsList addObjectsFromArray:tempDoctors];
         [doctorsList addObjectsFromArray:newDoctors];
         */
        NSLog(@"doctorsList antes del reload action %@", doctorsList);
        
        doctorsStatic = [docsList objectForKey:@"items"];
        NSLog(@"doctorsStatic con los nuevos docs = %@", doctorsStatic);
        NSDictionary *nextPageDic = [doctorsList mutableCopy];
        //doctorsList = [NSMutableDictionary dictionaryWithCapacity:20];
        doctorsList = [[NSMutableDictionary alloc]init];
        [doctorsList addEntriesFromDictionary:doctorsStatic];
        [doctorsList addEntriesFromDictionary:nextPageDic];
        
        
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
        doctorsList = [docsList objectForKey:@"items"];
        NSLog(@"%@", doctorsList);
        [UIView animateWithDuration:0.2 animations:^{
          self.tableView.alpha = 1.0;
          self.activityIndicatorMain.alpha = 0.0;
        }];
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

-(void)makeRequestSearch:(NSMutableDictionary *)paramsSentOver
{
  NSMutableDictionary *paramsSearch = [[NSMutableDictionary alloc]init];
  if (nextPage) {
    NSString *pageNumberStringValue = [NSString stringWithFormat:@"%d", pageNumber];
    [paramsSearch setValue:pageNumberStringValue forKey:@"pagina"];
  }
  if (![paramsSentOver isKindOfClass:[NSNull class]]) {
    [paramsSearch addEntriesFromDictionary:paramsReadyToSearch];
  }
  [paramsSearch setValue:@"1" forKey:@"opt"];
  [paramsSearch setValue:self.searchTextField.text forKey:@"palabras"];
  [paramsSearch setValue:@"10" forKey:@"limite"];
  [paramsSearch setValue:@"693e099a65935c5f839fab1330c8d360" forKey:@"key"];
  
  [ApplicationDelegate.infoEngine searchDoctors:paramsSearch completionHandler:^(NSDictionary *docsList){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
      //When the list is null means: No doctors on the list.
      if ([docsList count] == 0) {
        NSLog(@"dcotorsList dentro primer ir = %@", doctorsList);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alerta"
                                                        message:@"No hay doctores en esta region"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancelar"
                                              otherButtonTitles:nil];
        [alert show];
      }else{
        initApp = NO;
        if (nextPage && search) {
          /* NSLog(@"aqui valor de docsList = %@", docsList);
           NSMutableArray *tempDoctors = [doctorsList mutableCopy];
           NSMutableArray *newDoctors = [docsList mutableCopy];
           doctorsList = [[NSMutableArray alloc]init];
           [doctorsList addObjectsFromArray:tempDoctors];
           [doctorsList addObjectsFromArray:newDoctors];
           */
          
          doctorsStatic = [docsList objectForKey:@"items"];
          NSDictionary *nextPageDic = [doctorsList mutableCopy];
          doctorsList = [NSMutableDictionary dictionaryWithCapacity:20];
          [doctorsList addEntriesFromDictionary:doctorsStatic];
          [doctorsList addEntriesFromDictionary:nextPageDic];
          
          /*for (NSMutableArray *doctors in tempDoctors){
           [doctorsList addObject:doctors];
           }*/
          NSLog(@"New list count = %lu", (unsigned long)[doctorsList count]);
          NSLog(@"New full list of doctors = %@", doctorsList);
          isInsertingRow = YES;
          dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:lastIndexPathRow inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
          });
          isInsertingRow = NO;
        }else{
          doctorsList = [docsList objectForKey:@"items"];
          previousSpecialtiesDictionary = specialtiesDictionary;
          
          
          specialtiesDictionary = [[docsList objectForKey:@"facets"] objectForKey:@"category_tid"];
          
          NSLog(@"especialidades raw %@", specialtiesDictionary);
          if ([specialtiesDictionary count] == 0) {
            NSLog(@"Se quedan las especialidades anteriores");
          }else{
            specialtiesObjectArray = [[NSMutableArray alloc]init];
            
            for (NSString *categoryIndexTid in specialtiesDictionary) {
              Specialty *categoryReturned = [CategoriesDictionary returnSpecialty:categoryIndexTid];
              
              //NSLog(@"CATEGORY RETURNED %@, %@, %@ ", categoryReturned.displayName, categoryReturned.tid, [specialtiesDictionary objectForKey:categoryIndexTid]);
              
              Specialty *specialtyItem = [Specialty new];
              specialtyItem.displayName = categoryReturned.displayName;
              specialtyItem.tid = categoryReturned.tid;
              specialtyItem.instances = [specialtiesDictionary objectForKey:categoryIndexTid];
              [specialtiesObjectArray addObject:specialtyItem];
            }
            /*[[NSOperationQueue mainQueue] addOperationWithBlock:^{
             [self.filtersTableViewCategories reloadData];
             }];*/
          }
          
          previousStatesDictionary = statesDictionary;
          
          
          statesDictionary = [[docsList objectForKey:@"facets"] objectForKey:@"state_tid"];
          NSLog(@"estados raw %@", statesDictionary);
          if ([statesDictionary count] == 0) {
            NSLog(@"se quedan los estados anteriores");
          }else{
            statesObjectArray = [[NSMutableArray alloc]init];
            for (NSString *stateIndexTid in statesDictionary) {
              State *stateReturned = [StatesDictionary returnState:stateIndexTid];
              
              State *stateItem = [State new];
              stateItem.displayName = stateReturned.displayName;
              stateItem.tid = stateReturned.tid;
              stateItem.instances = [statesDictionary objectForKey:stateIndexTid];
              [statesObjectArray addObject:stateItem];
              
              //NSLog(@"STATE RETURNED %@, %@, %@", stateReturned.displayName, stateReturned.tid, [statesDictionary objectForKey:stateIndexTid])
            }
            /*[[NSOperationQueue mainQueue] addOperationWithBlock:^{
             [self.filtersTableView reloadData];
             }];*/
          }
          NSLog(@"Doctors List: %@", doctorsList);
          dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.filtersTableView reloadData];
            [self.filtersTableViewCategories reloadData];
          });
        }
      }
    });
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
  if (tableView == self.tableView) {
    /*int count;
    if (self.deleteRow) {
      count = [doctorsList count];
    } else{
      count = [doctorsList count] + 1;
    }*/
    return [doctorsList count] + 2;
  }else{
    if (tableView == self.filtersTableView) {
      return [statesObjectArray count];
    }else if (tableView == self.filtersTableViewCategories)
      return [specialtiesObjectArray count];
    else
      return 1;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (tableView == self.tableView) {
    if (indexPath.row == 0) {
      FirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier];
      NSLog(@"Cell for row at index path Primera celda!");
      lastIndexPathRow = indexPath.row;
      
      if (search)
        firstCell.nameLabel.text = @"Búsqueda Actual";
      else
        firstCell.nameLabel.text = @"Directorio Médico";
      
      [firstCell.iconContainer setImage:[UIImage imageNamed:@"firstCellIcon.png"]];
      
      [firstCell updateFonts];
      
      [firstCell setNeedsUpdateConstraints];
      [firstCell updateConstraintsIfNeeded];
      
      return firstCell;
    }else{
      if (indexPath.row == [doctorsList count] + 1) {
        LoadingMoreTableViewCell *lastCell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
        NSLog(@"Ultima celda!");
        lastIndexPathRow = indexPath.row;
        lastCell.nameLabel.text = @"Cargar Mas Resultados";
        return lastCell;
        
      }else{
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        //NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row];
        
        
        NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row - 1];
        
        NSString *nameText = [[doctorsList objectForKey:doctor] objectForKey:@"nombre"];
        NSMutableAttributedString *nameAttributedText = [[NSMutableAttributedString alloc] initWithString:nameText];
        NSMutableParagraphStyle *nameParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        [nameParagraphStyle setLineSpacing:0.0f];
        [nameAttributedText addAttribute:NSParagraphStyleAttributeName value:nameParagraphStyle range:NSMakeRange(0, nameText.length)];
        cell.nameLabel.attributedText = nameAttributedText;
        
        NSString *summaryText = [[doctorsList objectForKey:doctor] objectForKey:@"extracto"];
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
        
        cell.phonelabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"telefono"];
        
        cell.streetLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"calle"];
        
        cell.coloniaLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"colonia"];
        
        
        if ([[[doctorsList objectForKey:doctor] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
          [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
        }else{
          NSString *photo = [[doctorsList objectForKey:doctor] objectForKey:@"img"];
          [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        }
        
        NSString *pointsText = [NSString stringWithFormat:@"%@ puntos", [[doctorsList objectForKey:doctor] objectForKey:@"puntos"]];
        cell.pointsLabel.text = pointsText;
        
        cell.cityLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"ciudad"];
        
        cell.titleLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"titulo"];
        
        cell.schoolLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"escuela"];
        
        
        [cell updateFonts];
        
        [cell setNeedsUpdateConstraints];
        [cell updateConstraintsIfNeeded];
        
        return cell;
      }
    }
  }else{
    if (tableView == self.filtersTableView) {
      FiltersTableViewCell *filtersCell = [tableView dequeueReusableCellWithIdentifier:FiltersCellIdentifier];
      
      if (filterOption == 1) {
        State *states = [statesObjectArray objectAtIndex:indexPath.row];
        filtersCell.nameLabel.text = states.displayName;
        filtersCell.instancesLabel.text = [NSString stringWithFormat:@"%@", states.instances];
      }
      /*if (filterOption == 2) {
       Specialty *specialties = [specialtiesObjectArray objectAtIndex:indexPath.row];
       filtersCell.nameLabel.text = specialties.displayName;
       }*/
      [filtersCell setNeedsUpdateConstraints];
      [filtersCell updateConstraintsIfNeeded];
      
      return filtersCell;
    }else{
      FiltersTableViewCell *filtersCellCategory = [tableView dequeueReusableCellWithIdentifier:FiltersCellIdentifier];
      
      /*if (filterOption == 1) {
       State *states = [statesObjectArray objectAtIndex:indexPath.row];
       filtersCell.nameLabel.text = states.displayName;
       }*/
      if (filterOption == 2) {
        Specialty *specialties = [specialtiesObjectArray objectAtIndex:indexPath.row];
        filtersCellCategory.nameLabel.text = specialties.displayName;
        filtersCellCategory.instancesLabel.text = [NSString stringWithFormat:@"%@", specialties.instances];
      }
      [filtersCellCategory setNeedsUpdateConstraints];
      [filtersCellCategory updateConstraintsIfNeeded];
      
      return filtersCellCategory;
    }
  }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (tableView == self.tableView) {
    if (initApp == NO) {
      if (indexPath.row == [doctorsList count] + 1 ) {
        
        CGFloat height = 62;
        
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
          
          NSString *doctor = [NSString stringWithFormat:@"doctor%d",indexPath.row - 1];
          
          NSString *nameText = [[doctorsList objectForKey:doctor] objectForKey:@"nombre"];
          NSMutableAttributedString *nameAttributedText = [[NSMutableAttributedString alloc] initWithString:nameText];
          NSMutableParagraphStyle *nameParagraphStyle = [[NSMutableParagraphStyle alloc] init];
          [nameParagraphStyle setLineSpacing:0.0f];
          [nameAttributedText addAttribute:NSParagraphStyleAttributeName value:nameParagraphStyle range:NSMakeRange(0, nameText.length)];
          cell.nameLabel.attributedText = nameAttributedText;
          
          NSString *summaryText = [[doctorsList objectForKey:doctor] objectForKey:@"extracto"];
          
          NSMutableAttributedString *bodyAttributedText = [[NSMutableAttributedString alloc] initWithString:summaryText];
          NSMutableParagraphStyle *bodyParagraphStyle = [[NSMutableParagraphStyle alloc] init];
          [bodyParagraphStyle setLineSpacing:0.0f];
          [bodyAttributedText addAttribute:NSParagraphStyleAttributeName value:bodyParagraphStyle range:NSMakeRange(0, summaryText.length)];
          cell.summaryLabel.attributedText = bodyAttributedText;
          
          cell.phonelabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"telefono"];
          
          cell.streetLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"calle"];
          
          cell.coloniaLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"colonia"];
          
          
          if ([[[doctorsList objectForKey:doctor] objectForKey:@"img"] isKindOfClass:[NSNull class]]){
            [cell.photoImageView setImage:[UIImage imageNamed:@"placeholder.png"]];
          }else{
            NSString *photo = [[doctorsList objectForKey:doctor] objectForKey:@"img"];
            [cell.photoImageView setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"placeholder.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
          }
          
          NSString *pointsText = [NSString stringWithFormat:@"%@ puntos", [[doctorsList objectForKey:doctor] objectForKey:@"puntos"]];
          cell.pointsLabel.text = pointsText;
          
          cell.cityLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"ciudad"];
          
          cell.titleLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"titulo"];
          
          cell.schoolLabel.text = [[doctorsList objectForKey:doctor] objectForKey:@"escuela"];
          
          
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
  }else if(tableView == self.filtersTableView || tableView == self.filtersTableViewCategories){
    return 40;
  }else
    return 0;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == [doctorsList count] + 1) {
    [self loadMoreResultsMethod];
  }
  
  if (tableView == self.tableView) {
    NSLog(@"Main table view row selected");
  }
  if (tableView == self.filtersTableView) {
    State *states = [statesObjectArray objectAtIndex:indexPath.row];
    [paramsReadyToSearch setValue:states.tid forKey:@"estado"];
    NSLog(@"%@", paramsReadyToSearch);
  }
  if (tableView == self.filtersTableViewCategories) {
    Specialty *specialties = [specialtiesObjectArray objectAtIndex:indexPath.row];
    [paramsReadyToSearch setValue:specialties.tid forKey:@"especialidad"];
    NSLog(@"%@", paramsReadyToSearch);
  }
}

#pragma mark - Scroll View Did Scroll
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
  if (scrollView.contentOffset.y <= 45 && scrollView.contentOffset.y > 0) {
    [self animateNavigationBar:scrollView.contentOffset.y];
    [self animateResultsTableView:scrollView.contentOffset.y];
  }
  if (scrollView.contentOffset.y <= 0) {
    navbarLayer.position = CGPointMake(navbarLayer.position.x, self.navigationController.navigationBar.frame.size.height - 2);
    [[self tableTopConstraint] setConstant:-4];
    //[[self topConstraintFiltersView] setConstant:10];
    //[[self filtersView] layoutIfNeeded];
    [self animateNavigationBar:0];
  }
  if (scrollView.contentOffset.y > 45) {
    navbarLayer.position = CGPointMake(navbarLayer.position.x, -3);
    [[self tableTopConstraint] setConstant:-45];
    doctorsButton.alpha = 0;
    searchButton.alpha = 0;
    navTitleLabel.alpha = 0;
  }
}

#pragma mark - Animate Navigation bar

- (void)animateNavigationBar:(CGFloat)offSet
{
  float transparency;
  transparency = (45-offSet)/45;
  CGFloat transValue = transparency;
  
  doctorsButton.alpha = transValue;
  searchButton.alpha = transValue;
  navTitleLabel.alpha = transValue;
  
  if (!search) {
    [UIView animateWithDuration:0.0 animations:^{
      navbarLayer.position =CGPointMake(navbarLayer.position.x, self.navigationController.navigationBar.frame.size.height - offSet - 2);
    }];
  }else{
    
  }
}

-(void)animateResultsTableView:(CGFloat)offSet
{
  NSLog(@"TOP CONTRAINT TABLE= %@", [self tableTopConstraint]);
  [UIView animateWithDuration:0.0 animations:^{
    if (search) {
      if (offSet <= 35 && offSet >= 0) {
        [[self topConstraintFiltersView] setConstant:35-offSet];
      }
      //[[self topConstraintFiltersView] setConstant:-offSet-32];
      [[self tableTopConstraint] setConstant:-offSet - 2];
    }else{
      [[self tableTopConstraint] setConstant:-offSet-3];
    }
    [self.view layoutIfNeeded];
    [[self tableView] layoutIfNeeded];
    [[self filtersView] layoutIfNeeded];
  }];
}

#pragma mark - Load more results
- (IBAction)loadMoreResults:(id)sender {
  
  nextPage = YES;
  ++pageNumber;
  [self getDoctorsFromLocation:[latitude stringValue] andLongitude:[longitude stringValue]];
  
}

-(void)loadMoreResultsMethod
{
  nextPage = YES;
  ++pageNumber;
  if (search) {
    [self makeRequestSearch:NULL];
  }else{
    [self getDoctorsFromLocation:[latitude stringValue] andLongitude:[longitude stringValue]];
  }
}


#pragma mark - Hit enter search view
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
  search = YES;
  nextPage = NO;
  newFilters = NO;
  filterOption = 1;
  paramsReadyToSearch = [[NSMutableDictionary alloc]init];
  [self.view addSubview:self.filtersView];
  [self.view addSubview:self.showFilterOptionsButton];
  [self.view addSubview:self.gradientFilterCancelButton];
  [self.view addSubview:self.gradientFilterSearchButton];
  [self.view addSubview:self.selectFilterStateButton];
  [self.view addSubview:self.selectFilterCategoryButton];
  [self.view addSubview:self.filtersTableView];
  [self.view addSubview:self.filtersTableViewCategories];
  
  UILabel *filtersCancelButtonLabel = self.filtersButtonCancelLabel;
  UILabel *filtersSearchButtonLabel = self.filtersButtonSearchLabel;
  [filtersSearchButtonLabel setText:@"Buscar"];
  [filtersCancelButtonLabel setText:@"Cancelar"];
  [self.gradientFilterSearchButton addSubview:filtersSearchButtonLabel];
  [self.gradientFilterCancelButton addSubview:filtersCancelButtonLabel];
  
  NSMutableAttributedString *stateNameString = [[NSMutableAttributedString alloc] initWithString:@"Estado"];
  [stateNameString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [stateNameString length])];
  [self.filtersButtonStateLabel setAttributedText:stateNameString];
  [self.filtersButtonCategoryLabel setText:@"Especialidad"];
  [self.selectFilterStateButton addSubview:self.filtersButtonStateLabel];
  [self.selectFilterCategoryButton addSubview:self.filtersButtonCategoryLabel];
  
  if (filterOption == 1) {
    self.selectFilterStateButton.gradientColors = [NSArray arrayWithObjects:[UIColor whiteColor], [UIColor whiteColor ], nil];
  }
  
  [UIView animateWithDuration:0.2 animations:^{
    self.tableView.alpha = 1.0;
    self.activityIndicatorMain.alpha = 0.0;
  }];
  
  [self.filtersTableView reloadData];
  [self.filtersTableViewCategories reloadData];
  [self dismissSearch];
  [self makeRequestSearch:NULL];
  [self.view setNeedsUpdateConstraints];
  return YES;
  
}

#pragma mark - Open filters option
-(void)showFilterOptionsMethod:(id)sender
{
  //[self.filtersTableViewCategories reloadData];
  //[self.filtersTableView reloadData];
  
  if (filtersOpen) {
    [UIView animateWithDuration:0.2 animations:^{
      self.filtersTableView.alpha = 0.0;
      self.filtersTableViewCategories.alpha = 0.0;
      self.gradientFilterSearchButton.alpha = 0.0;
      self.gradientFilterCancelButton.alpha = 0.0;
      self.selectFilterStateButton.alpha = 0.0;
      self.selectFilterCategoryButton.alpha = 0.0;
      self.filtersButtonStateLabel.alpha = 0.0;
      self.filtersButtonCategoryLabel.alpha = 0.0;
    }completion:^(BOOL finished) {
      [UIView animateWithDuration:0.3 animations:^(void){
        self.tableTopConstraint.constant = 35.0;
        [self.tableView layoutIfNeeded];
        [self.filtersView layoutIfNeeded];
      }];
    }];
    filtersOpen = NO;
    self.tableView.scrollEnabled = YES;
  }else{
    
    if (![statesDictionary count] == 0) {
      //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //[self.filtersTableView reloadData];
      //}];
    }
    if (![specialtiesDictionary count] == 0) {
      //[[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        //[self.filtersTableViewCategories reloadData];
      //}];
    }
    
    [UIView animateWithDuration:0.3 animations:^(void){
      self.tableTopConstraint.constant = 210.0;
      [self.tableView layoutIfNeeded];
      [self.filtersView layoutIfNeeded];
    }completion:^(BOOL finished) {
      [UIView animateWithDuration:0.2 animations:^{
        if (filterOption == 1)
          self.filtersTableView.alpha = 1.0;
        if (filterOption == 2)
          self.filtersTableViewCategories.alpha = 1.0;
        self.gradientFilterSearchButton.alpha = 1.0;
        self.gradientFilterCancelButton.alpha = 1.0;
        self.selectFilterStateButton.alpha = 1.0;
        self.selectFilterCategoryButton.alpha = 1.0;
        self.filtersButtonStateLabel.alpha = 1.0;
        self.filtersButtonCategoryLabel.alpha = 1.0;
      }];
    }];
    filtersOpen = YES;
    self.tableView.scrollEnabled = NO;
    
  }
}

- (IBAction)searchButton:(id)sender {
  self.searchBar.alpha = 1.0;
  [UIView animateWithDuration:0.3 animations:^(void){
    self.searchContentView.alpha = 1.0;
    self.overlaySearchBackground.alpha = 0.7;
  }completion:^(BOOL finished){
    [self.searchTextField becomeFirstResponder];
  }];
  
  [self.view setNeedsUpdateConstraints];
}

-(void)setupViews
{
  [self.navigationController.view addSubview:self.searchContentView];
  //[self.view addSubview:self.filtersView];
  //[self.view addSubview:self.showFilterOptionsButton];
  [self.searchContentView addSubview:self.overlaySearchBackground];
  [self.searchContentView addSubview:self.searchBar];
  [self.searchBar addSubview:self.searchTextField];
}

#pragma mark - Constraints
-(void)updateViewConstraints
{
  [super updateViewConstraints];
  
  [self.activityIndicatorMain autoCenterInSuperview];
  
  self.topViewConstraint = [self.view autoPinToTopLayoutGuideOfViewController:self withInset:-20.0];
  
  [self.searchContentView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0f];
  [self.searchContentView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
  [self.searchContentView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0.0f];
  [self.searchContentView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0.0f];
  
  
  //[self.tableView autoPinToBottomLayoutGuideOfViewController:self withInset:20.0];
  
  [self overlayBlackBackgroundLayout];
  [self searchBarlayout];
  [self searchTextFieldLayout];
  if (search) {
    [self filtersViewLayout];
  }
  
  
}

-(void)overlayBlackBackgroundLayout
{
  [self.overlaySearchBackground autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0.0];
  [self.overlaySearchBackground autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0];
  [self.overlaySearchBackground autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0];
  [self.overlaySearchBackground autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0];
}

-(void)searchBarlayout
{
  self.topConstraintSearchBar = [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:-66.0];
  [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0.0];
  [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0.0];
  [self.searchBar autoSetDimension:ALDimensionHeight toSize:66];
  //[self.navigationController.view layoutIfNeeded];
  [self.searchContentView layoutIfNeeded];
  
  double delayInSeconds = 0.3;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self animateSearchBar];
  });
  
}

-(void)searchTextFieldLayout
{
  [self.searchTextField autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30.0f];
  [self.searchTextField autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:30.0f];
  [self.searchTextField autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:30.0f];
  [self.searchTextField autoSetDimension:ALDimensionHeight toSize:25.0f];
  [self.searchContentView layoutIfNeeded];
}

-(void)filtersViewLayout
{
  self.topConstraintFiltersView = [self.filtersView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
  [self.filtersView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
  [self.filtersView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
  //self.heighConstraintFiltersView = [self.filtersView autoSetDimension:ALDimensionHeight toSize:30];
  [self.filtersView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.tableView withOffset:5];
  
  [self.showFilterOptionsButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
  [self.showFilterOptionsButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:20];
  //[self.showFilterOptionsButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
  
  [self.filtersTableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.showFilterOptionsButton withOffset:25.0];
  [self.filtersTableView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:22.0];
  [self.filtersTableView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:22.0];
  //[self.filtersTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.filtersView withOffset:-5.0];
  [self.filtersTableView autoSetDimension:ALDimensionHeight toSize:100];
  
  [self.filtersTableViewCategories autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.showFilterOptionsButton withOffset:25.0];
  [self.filtersTableViewCategories autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:22.0];
  [self.filtersTableViewCategories autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:22.0];
  [self.filtersTableViewCategories autoSetDimension:ALDimensionHeight toSize:100];
  
  [self.gradientFilterSearchButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.filtersTableView withOffset:10.0];
  [self.gradientFilterSearchButton autoPinEdge:ALEdgeTrailing toEdge:ALEdgeTrailing ofView:self.filtersTableView];
  [self.gradientFilterSearchButton autoSetDimension:ALDimensionWidth toSize:70.0];
  [self.gradientFilterSearchButton autoSetDimension:ALDimensionHeight toSize:30.0];
  
  [self.gradientFilterCancelButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.filtersTableView withOffset:10.0];
  [self.gradientFilterCancelButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.filtersTableView];
  [self.gradientFilterCancelButton autoSetDimension:ALDimensionWidth toSize:70.0];
  [self.gradientFilterCancelButton autoSetDimension:ALDimensionHeight toSize:30.0];
  
  [self.filtersButtonSearchLabel autoCenterInSuperview];
  [self.filtersButtonCancelLabel autoCenterInSuperview];
  
  [self.selectFilterStateButton autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:self.filtersTableView];
  [self.selectFilterStateButton autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.filtersTableView];
  [self.selectFilterStateButton autoSetDimension:ALDimensionHeight toSize:20.0];
  [self.selectFilterStateButton autoSetDimension:ALDimensionWidth toSize:67.0];
  
  [self.selectFilterCategoryButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.selectFilterStateButton];
  [self.selectFilterCategoryButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.selectFilterStateButton withOffset:10.0];
  [self.selectFilterCategoryButton autoSetDimension:ALDimensionHeight toSize:20.0];
  [self.selectFilterCategoryButton autoSetDimension:ALDimensionWidth toSize:100.0];
  
  [self.filtersButtonStateLabel autoCenterInSuperview];
  [self.filtersButtonCategoryLabel autoCenterInSuperview];
  
  //[self.filtersTableViewStateLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15.0];
  //[self.filtersTableViewStateLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:3.0];
  
  [self.view layoutIfNeeded];
}

-(void)animateSearchBar
{
  [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    self.topConstraintSearchBar.constant = 0.0f;
    [self.searchContentView layoutIfNeeded];
  }completion:^(BOOL finished){
    return;
  }];
}

#pragma mark - Dismiss Search
-(void)dismissSearch
{
  [UIView animateWithDuration:0.2 animations:^(void){
    self.searchContentView.alpha = 0.0;
    [self.searchTextField resignFirstResponder];
  }completion:^(BOOL finished){
    if (search) {
      [UIView animateWithDuration:0.2 animations:^(void){
        [self.tableTopConstraint setConstant:35.0];
        self.filtersView.alpha = 1;
        self.showFilterOptionsButton.alpha = 1;
        [self addFiltersOptions];
        [self.tableView layoutIfNeeded];
      }];
    }
  }];
  filters = YES;
}

#pragma mark - Search and Cancell buttons - States and Categories tabs
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  
  UITouch *touch = [touches anyObject];
  if([touch.view tag] == 1){
    NSLog(@"Search button touched");
    
    if (filterOption == 1) {
      NSLog(@"Delete previous specialties . filterOption = %d", filterOption);
      NSLog(@"Number of previousSpecialtiesDictionary = %d", [previousSpecialtiesDictionary count]);
      
      /*
      [self.filtersTableViewCategories beginUpdates];
      NSMutableArray *rowsToDelete = [NSMutableArray new];
      for (NSUInteger i = 0; i < [previousSpecialtiesDictionary count]; i++) {
        [rowsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:0]];
      }
      specialtiesDictionary = [[NSDictionary alloc]init];
      
      [self.filtersTableViewCategories deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationNone];
      [self.filtersTableViewCategories reloadData];
      [self.filtersTableViewCategories endUpdates]; */
    }
    
    if (filterOption == 2) {
      NSLog(@"Delete previous states. filterOption = %d", filterOption);
      NSLog(@"Number of previousStatesDictionary = %d", [previousStatesDictionary count]);
      
      /*
      [self.filtersTableView beginUpdates];
      NSMutableArray *rowsToDelete = [NSMutableArray new];
      for (NSUInteger i = 0; i < [previousStatesDictionary count]; i++) {
        [rowsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:0]];
      }
      statesDictionary = [[NSDictionary alloc]init];
      
      [self.filtersTableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationNone];
      [self.filtersTableView reloadData];
      [self.filtersTableView endUpdates];*/
    }
    
    [self makeRequestSearch:paramsReadyToSearch];
    [self closeFilterOptions];
    newFilters = YES;
    //[self.filtersTableView reloadData];
    //[self.filtersTableViewCategories reloadData];
  }
  if ([touch.view tag] == 2){
    NSLog(@"Cancel button touched");
    [self closeFilterOptions];
  }
  
  
  if ([touch.view tag] == 3){
    if (onceState) {
      [self.filtersTableView reloadData];
      onceState = NO;
    }
    NSLog(@"States button touched");
    filterOption = 1;
    [UIView animateWithDuration:0.4 animations:^{
      self.filtersTableViewCategories.alpha = 0.0;
    }completion:^(BOOL finished) {
      [UIView animateWithDuration:0.4 animations:^{
        self.filtersTableView.alpha = 1.0;
      }];
    }];
    
    self.selectFilterStateButton.gradientColors = [NSArray arrayWithObjects:[UIColor whiteColor], [UIColor whiteColor], nil];
    self.selectFilterCategoryButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0xDBDBEA], [UIColor colorWithRGB:0xDBDBEA ], nil];
    
    NSMutableAttributedString *stateNameString = [[NSMutableAttributedString alloc] initWithString:@"Estado"];
    [stateNameString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [stateNameString length])];
    [self.filtersButtonStateLabel setAttributedText:stateNameString];
    
    NSMutableAttributedString *categoryNameString = [[NSMutableAttributedString alloc] initWithString:@"Especialidad"];
    [categoryNameString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [categoryNameString length])];
    [self.filtersButtonCategoryLabel setAttributedText:categoryNameString];
  }
  if ([touch.view tag] == 4) {
    if(onceCategory){
      [self.filtersTableViewCategories reloadData];
      onceCategory = NO;
    }
    NSLog(@"Category button touched");
    [UIView animateWithDuration:0.3 animations:^{
      self.filtersTableView.alpha = 0.0;
    }completion:^(BOOL finished) {
      [UIView animateWithDuration:0.3 animations:^{
        self.filtersTableViewCategories.alpha = 1.0;
      }];
    }];
    
    filterOption = 2;
    self.selectFilterStateButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0xDBDBEA], [UIColor colorWithRGB:0xDBDBEA ], nil];
    self.selectFilterCategoryButton.gradientColors = [NSArray arrayWithObjects:[UIColor whiteColor], [UIColor whiteColor], nil];
    
    NSMutableAttributedString *stateNameString = [[NSMutableAttributedString alloc] initWithString:@"Estado"];
    [stateNameString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [stateNameString length])];
    [self.filtersButtonStateLabel setAttributedText:stateNameString];
    
    NSMutableAttributedString *categoryNameString = [[NSMutableAttributedString alloc] initWithString:@"Especialidad"];
    [categoryNameString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [categoryNameString length])];
    [self.filtersButtonCategoryLabel setAttributedText:categoryNameString];
  }
  
}

-(void)closeFilterOptions
{
  [UIView animateWithDuration:0.3 animations:^{
    self.filtersTableView.alpha = 0.0;
    self.filtersTableViewCategories.alpha = 0.0;
    self.gradientFilterSearchButton.alpha = 0.0;
    self.gradientFilterCancelButton.alpha = 0.0;
    self.selectFilterStateButton.alpha = 0.0;
    self.selectFilterCategoryButton.alpha = 0.0;
    self.filtersButtonStateLabel.alpha = 0.0;
    self.filtersButtonCategoryLabel.alpha = 0.0;
  }completion:^(BOOL finished) {
    [UIView animateWithDuration:0.2 animations:^(void){
      self.tableTopConstraint.constant = 35.0;
      [self.tableView layoutIfNeeded];
      [self.filtersView layoutIfNeeded];
    }];
  }];
  filtersOpen = NO;
  self.tableView.scrollEnabled = YES;
}


-(void)addFiltersOptions
{
  
}


#pragma mark - Subclass each element
-(UILabel *)filtersButtonStateLabel
{
  UIFont *sourceSansProRegular13 = [UIFont fontWithName:@"SourceSansPro-Regular" size:13];
  if (!_filtersButtonStateLabel) {
    _filtersButtonStateLabel = [UILabel newAutoLayoutView];
    [_filtersButtonStateLabel setFont:sourceSansProRegular13];
    [_filtersButtonStateLabel setTextColor:[UIColor blackColor]];
    [_filtersButtonStateLabel setAlpha:0.0];
  }
  return _filtersButtonStateLabel;
}

-(UILabel *)filtersButtonCategoryLabel
{
  UIFont *sourceSansProRegular13 = [UIFont fontWithName:@"SourceSansPro-Regular" size:13];
  if (!_filtersButtonCategoryLabel) {
    _filtersButtonCategoryLabel = [UILabel newAutoLayoutView];
    [_filtersButtonCategoryLabel setFont:sourceSansProRegular13];
    [_filtersButtonCategoryLabel setTextColor:[UIColor blackColor]];
    [_filtersButtonCategoryLabel setAlpha:0.0];
  }
  return _filtersButtonCategoryLabel;
}

-(GRKGradientView *)selectFilterStateButton
{
  if (!_selectFilterStateButton) {
    _selectFilterStateButton = [GRKGradientView newAutoLayoutView];
    _selectFilterStateButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0xDBDBEA], [UIColor colorWithRGB:0xDBDBEA ], nil];
    //_selectFilterStateButton.layer.borderColor = [UIColor colorWithRGB:0xccd0c9].CGColor;
    //_selectFilterStateButton.layer.borderWidth = 1.0f;
    _selectFilterStateButton.alpha = 0.0;
    _selectFilterStateButton.tag = 3;
  }
  return _selectFilterStateButton;
}

-(GRKGradientView *)selectFilterCategoryButton
{
  if (!_selectFilterCategoryButton) {
    _selectFilterCategoryButton = [GRKGradientView newAutoLayoutView];
    _selectFilterCategoryButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0xDBDBEA], [UIColor colorWithRGB:0xDBDBEA ], nil];
    //_selectFilterCategoryButton.layer.borderColor = [UIColor colorWithRGB:0xccd0c9].CGColor;
    //_selectFilterCategoryButton.layer.borderWidth = 1.0f;
    _selectFilterCategoryButton.alpha = 0.0;
    _selectFilterCategoryButton.tag = 4;
  }
  return _selectFilterCategoryButton;
}

-(UILabel *)filtersButtonCancelLabel
{
  UIFont *sourceSansProSemibold14 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:14];
  if (!_filtersButtonCancelLabel) {
    _filtersButtonCancelLabel = [UILabel newAutoLayoutView];
    [_filtersButtonCancelLabel setFont:sourceSansProSemibold14];
    [_filtersButtonCancelLabel setTextColor:[UIColor whiteColor]];
    
  }
  return _filtersButtonCancelLabel;
}

-(UILabel *)filtersButtonSearchLabel
{
  UIFont *sourceSansProSemibold13 = [UIFont fontWithName:@"SourceSansPro-Semibold" size:14];
  if (!_filtersButtonSearchLabel) {
    _filtersButtonSearchLabel = [UILabel newAutoLayoutView];
    [_filtersButtonSearchLabel setFont:sourceSansProSemibold13];
    [_filtersButtonSearchLabel setTextColor:[UIColor whiteColor]];
    
  }
  return _filtersButtonSearchLabel;
}

-(GRKGradientView *)gradientFilterCancelButton
{
  if (!_gradientFilterCancelButton) {
    _gradientFilterCancelButton = [GRKGradientView newAutoLayoutView];
    _gradientFilterCancelButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0xc00000], [UIColor colorWithRGB:0x990000 ], nil];
    _gradientFilterCancelButton.layer.cornerRadius = 4;
    [[_gradientFilterCancelButton layer] setMasksToBounds:YES];
    _gradientFilterCancelButton.tag = 2;
    _gradientFilterCancelButton.alpha = 0.0;
    _gradientFilterCancelButton.userInteractionEnabled = YES;
  }
  return _gradientFilterCancelButton;
}


-(GRKGradientView *)gradientFilterSearchButton
{
  if (!_gradientFilterSearchButton) {
    _gradientFilterSearchButton = [GRKGradientView newAutoLayoutView];
    _gradientFilterSearchButton.gradientColors = [NSArray arrayWithObjects:[UIColor colorWithRGB:0x619b1b], [UIColor colorWithRGB:0x507f16 ], nil];
    _gradientFilterSearchButton.layer.cornerRadius = 4;
    [[_gradientFilterSearchButton layer] setMasksToBounds:YES];
    _gradientFilterSearchButton.tag = 1;
    _gradientFilterSearchButton.alpha = 0.0;
    _gradientFilterSearchButton.userInteractionEnabled = YES;
  }
  return _gradientFilterSearchButton;
}

-(UITableView *)filtersTableView
{
  if (!_filtersTableView) {
    _filtersTableView = [UITableView newAutoLayoutView];
    _filtersTableView.delegate = self;
    _filtersTableView.dataSource = self;
    _filtersTableView.alpha = 0.0;
  }
  return _filtersTableView;
}

-(UITableView *)filtersTableViewCategories
{
  if (!_filtersTableViewCategories) {
    _filtersTableViewCategories = [UITableView newAutoLayoutView];
    _filtersTableViewCategories.delegate = self;
    _filtersTableViewCategories.dataSource = self;
    _filtersTableViewCategories.alpha = 0.0;
  }
  return _filtersTableViewCategories;
}

-(UIButton *)showFilterOptionsButton
{
  if (!_showFilterOptionsButton) {
    _showFilterOptionsButton = [UIButton newAutoLayoutView];
    [_showFilterOptionsButton setTitle:@"Opciones de Búsqueda" forState:UIControlStateNormal];
    [_showFilterOptionsButton setTitleColor:[UIColor colorWithRGB:0x484848] forState:UIControlStateNormal];
    [_showFilterOptionsButton.titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Semibold" size:13]];
    _showFilterOptionsButton.alpha = 0.0;
  }
  return _showFilterOptionsButton;
}

- (UIView *)filtersView
{
  if (!_filtersView) {
    _filtersView = [UIView newAutoLayoutView];
    _filtersView.backgroundColor = [UIColor colorWithRGB:0xf4f8f0];
    _filtersView.alpha = 0.0;
    
    _filtersView.layer.cornerRadius = 7;
    _filtersView.layer.borderColor = [UIColor colorWithRGB:0xccd0c9].CGColor;
    _filtersView.layer.borderWidth = 1.0f;
    
    _filtersView.layer.shadowColor = [UIColor colorWithRGB:0xccd0c9].CGColor;
    _filtersView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    _filtersView.layer.shadowOpacity = 0.65f;
    _filtersView.layer.shadowRadius = 1.0f;
    _filtersView.layer.shouldRasterize = YES;
    _filtersView.opaque = YES;
    
  }
  return _filtersView;
}

- (UIView *)searchContentView
{
  if (!_searchContentView) {
    _searchContentView = [UIView newAutoLayoutView];
    _searchContentView.backgroundColor = [UIColor clearColor];
    _searchContentView.alpha = 0.0;
    
  }
  return _searchContentView;
}

- (UIView *)overlaySearchBackground
{
  if (!_overlaySearchBackground) {
    _overlaySearchBackground = [[UIView alloc] initForAutoLayout];
    _overlaySearchBackground.backgroundColor = [UIColor blackColor];
    _overlaySearchBackground.alpha = 0.0;
    
  }
  return _overlaySearchBackground;
}

- (UIView *)searchBar
{
  //colorWithRGB:0x619b1b
  if (!_searchBar) {
    _searchBar = [[UIView alloc] initForAutoLayout];
    _searchBar.backgroundColor = [UIColor colorWithRGB:0x619b1b];
    _searchBar.alpha = 0.0;
    
  }
  return _searchBar;
}

-(UITextField *)searchTextField
{
  if ((!_searchTextField)) {
    UIFont *sourceSansProRegular16 = [UIFont fontWithName:@"SourceSansPro-Regular" size:16];
    
    _searchTextField = [[UITextField alloc] initForAutoLayout];
    _searchTextField.font = sourceSansProRegular16;
    _searchTextField.backgroundColor = [UIColor whiteColor];
    [_searchTextField.layer setBorderColor:[[UIColor colorWithRGB:0xccd0c9]CGColor]];
    [_searchTextField.layer setBorderWidth:1.0];
    _searchTextField.layer.cornerRadius = 7;
    _searchTextField.delegate = self;
    
    _searchTextField.placeholder = @"Buscar Médicos";
    UIView *fieldSearch = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    _searchTextField.leftView = fieldSearch;
    
  }
  return _searchTextField;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
  CGRect rect = self.searchTextField.frame;
  rect = CGRectMake(20, rect.origin.y-4, rect.size.width-20, rect.size.height);
  return rect;
}


/*
 -(void)getSpecialtyMethod
 {
 NSMutableDictionary *postParams = [[NSMutableDictionary alloc]init];
 [postParams setValue:@"especialidad" forKey:@"disponible"];
 
 [ApplicationDelegate.infoEngine getStateSpecialty:postParams completionHandler:^(NSDictionary *categories){
 specialtiesDictionary = categories;
 
 NSDictionary *specialtyInDictionary = [[NSDictionary alloc]init];
 specialtiesObjectArray = [[NSMutableArray alloc]init];
 
 for (int i =1; i<=[specialtiesDictionary count]; i++) {
 NSString *index = [NSString stringWithFormat:@"especialidad%d",i];
 specialtyInDictionary = [specialtiesDictionary objectForKey:index];
 Specialty *specialtyItem = [Specialty new];
 specialtyItem.displayName = [specialtyInDictionary objectForKey:@"nombre"];
 specialtyItem.tid = [specialtyInDictionary objectForKey:@"tid"];
 [specialtiesObjectArray addObject:specialtyItem];
 }
 NSLog(@"Especialidades %@", specialtiesObjectArray);
 } errorHandler:^(NSError* error){
 }];
 }
 
 -(void)getStateMethod
 {
 NSMutableDictionary *postParams = [[NSMutableDictionary alloc]init];
 [postParams setValue:@"estado" forKey:@"disponible"];
 
 [ApplicationDelegate.infoEngine getStateSpecialty:postParams completionHandler:^(NSDictionary *categories){
 statesDictionary = categories;
 
 NSDictionary *stateInDictionary = [[NSDictionary alloc]init];
 statesObjectArray = [[NSMutableArray alloc]init];
 
 for (int i =1; i<=[statesDictionary count]; i++) {
 NSString *index = [NSString stringWithFormat:@"estado%d",i];
 stateInDictionary = [statesDictionary objectForKey:index];
 State *stateItem = [State new];
 stateItem.displayName = [stateInDictionary objectForKey:@"nombre"];
 stateItem.tid = [stateInDictionary objectForKey:@"tid"];
 [statesObjectArray addObject:stateItem];
 }
 NSLog(@"Estados %@", statesObjectArray);
 } errorHandler:^(NSError* error){
 }];
 }
 */
@end
